//
//  YHFavoriteWordController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/27.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHFavoriteWordController.h"
#import "YHWordTableViewCell.h"
#import "YHMeWordsApi.h"
#import "WordDataModel.h"
#import <MJRefresh.h>
#import <YYModel.h>
#import "YHMarkWordsApi.h"
#import "YHCancelCollectApi.h"
#import "YHMeCollectWordsListApi.h"

static NSInteger pagenumber = 0;

@interface YHFavoriteWordController ()<UITableViewDelegate,UITableViewDataSource,YTKRequestDelegate>

@property (nonatomic,strong) UITableView *favoriteWordTableView;

@property (nonatomic,strong) NSMutableArray<WordDataModel *> *datas;

@property (nonatomic,strong) YHMeCollectWordsListApi *collectWordsListApi;
@end

@implementation YHFavoriteWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收藏单词";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
     [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
    [self.collectWordsListApi start];
    [self.view addSubview:self.favoriteWordTableView];
    
    self.favoriteWordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    self.favoriteWordTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    [self.favoriteWordTableView.mj_header beginRefreshing];
    
    [self layoutPageViews];
}

- (void)layoutPageViews {
    [self.favoriteWordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight));
        make.edges.equalTo(self.view);
    }];
}

- (void)getNewData {
    pagenumber = 0;
    self.datas = nil;
    YHMeCollectWordsListApi *api = [[YHMeCollectWordsListApi alloc] initWithPage:1 row:5 userId:[YHUserManager sharedManager].userId token:[YHUserManager sharedManager].token];
    api.delegate = self;
    pagenumber = 1;
    [api start];
}

- (void)getMoreData {
    pagenumber += 1;
    YHMeCollectWordsListApi *api  = [[YHMeCollectWordsListApi alloc] initWithPage:pagenumber row:5 userId:[YHUserManager sharedManager].userId token:[YHUserManager sharedManager].token];
    api.delegate = self;
    [api start];
}

#pragma mark - YTKRequestDelegate
#pragma mark -
- (void)requestFinished:(__kindof YTKBaseRequest *)request {
    id obj = request.responseObject;
    id data = [(SFBaseApiRequest *)request fetchDataWithReformer:nil];
    if (![(SFBaseApiRequest *)request success]) {
        
        return;
    }
    
    if ([(SFBaseApiRequest *)request isKindOfClass:[YHMeCollectWordsListApi class]]) {
        NSArray *array = [NSArray yy_modelArrayWithClass:[WordDataModel class] json:data];
        
        if (pagenumber == 1) {
            [self.favoriteWordTableView.mj_header endRefreshing];
//            [self.rememberedWordTableView.mj_footer resetNoMoreData];
            
             self.datas = [NSMutableArray arrayWithArray:array];
        } else {
            [self.favoriteWordTableView.mj_footer endRefreshing];
            [self.datas addObjectsFromArray:array];
        }
        
       
        [self.favoriteWordTableView reloadData];
    }
    
    if ([(SFBaseApiRequest *)request isKindOfClass:[YHMarkWordsApi class]]) {
        NSLog(@"%@",obj[@"message"]);
    }
}

-(void)requestFailed:(__kindof YTKBaseRequest *)request {
    
}

#pragma mark - UITableViewDelegate
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YHWordTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *fuzzyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"模糊" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        WordDataModel *model = self.datas[indexPath.row];
        NSLog(@"标记%@ 为模糊单词",model.word);
        YHMarkWordsApi *api = [[YHMarkWordsApi alloc] initWithType:2 token:[YHUserManager sharedManager].token userId:[YHUserManager sharedManager].userId wordId:model.wordId];
        api.delegate = self;
        [api start];
        [self.favoriteWordTableView reloadData];
    }];
    
    UITableViewRowAction *likeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
           WordDataModel *model = self.datas[indexPath.row];
           NSLog(@"取消收藏单词%@",model.word);
        YHCancelCollectApi *api = [[YHCancelCollectApi alloc] initWithUserId:[YHUserManager sharedManager].userId token:[YHUserManager sharedManager].token wordId:model.wordId];
           api.delegate = self;
           [api start];
           [self.datas removeObjectAtIndex:indexPath.row];
           [self.favoriteWordTableView reloadData];
       }];
    
    return @[fuzzyAction,likeAction];
}
#pragma mark - UITaleViewDataSource
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHWordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHWordTableViewCell cellIdentifier] forIndexPath:indexPath];
    
    [cell configWithData:self.datas[indexPath.row]];
    
    [cell sf_addLineTop:YES bottom:YES leftSpace:10 rightSpace:10];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - getter and setter
#pragma mark -
- (UITableView *)favoriteWordTableView {
    if (!_favoriteWordTableView) {
        _favoriteWordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _favoriteWordTableView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        _favoriteWordTableView.showsVerticalScrollIndicator = NO;
        [_favoriteWordTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [_favoriteWordTableView registerClass:[YHWordTableViewCell class] forCellReuseIdentifier:[YHWordTableViewCell cellIdentifier]];
               
               _favoriteWordTableView.delegate = self;
               _favoriteWordTableView.dataSource = self;
    }
    return _favoriteWordTableView;
}


- (NSMutableArray<WordDataModel *> *)datas {
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}

- (YHMeCollectWordsListApi *)collectWordsListApi {
    if (!_collectWordsListApi) {
        _collectWordsListApi = [[YHMeCollectWordsListApi alloc] initWithPage:1 row:5 userId:[YHUserManager sharedManager].userId token:[YHUserManager sharedManager].token];
        _collectWordsListApi.delegate = self;
    }
    return _collectWordsListApi;
}
@end
