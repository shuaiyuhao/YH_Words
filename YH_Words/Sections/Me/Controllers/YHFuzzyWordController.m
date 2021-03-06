//
//  YHFuzzyWordController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/27.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHFuzzyWordController.h"
#import "YHWordTableViewCell.h"
#import "YHMeWordsApi.h"
#import "WordDataModel.h"
#import <MJRefresh.h>
#import <YYModel.h>
#import "YHMarkWordsApi.h"
#import "YHCollectWordApi.h"
#import "SFHUD.h"

static NSInteger pagenumber = 0;

@interface YHFuzzyWordController ()<UITableViewDelegate,UITableViewDataSource,YTKRequestDelegate>

@property (nonatomic,strong) UITableView *fuzzyWordTableView;

@property (nonatomic,strong) NSMutableArray<WordDataModel *> *datas;

@property (nonatomic,strong) YHMeWordsApi *fuzzyWordsApi;

@end

@implementation YHFuzzyWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"模糊单词";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
     [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
    [self.fuzzyWordsApi start];
    [self.view addSubview:self.fuzzyWordTableView];
    
    self.fuzzyWordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    self.fuzzyWordTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    [self.fuzzyWordTableView.mj_header beginRefreshing];
    
    [self layoutPageViews];
}

- (void)layoutPageViews {
    [self.fuzzyWordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight));
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - YTKRequestDelegate
#pragma mark -
- (void)requestFinished:(__kindof YTKBaseRequest *)request {
    id obj = request.responseObject;
    id data = [(SFBaseApiRequest *)request fetchDataWithReformer:nil];
    if (![(SFBaseApiRequest *)request success]) {
        
        return;
    }
    
    if ([(SFBaseApiRequest *)request isKindOfClass:[YHMeWordsApi class]]) {
        NSArray *array = [NSArray yy_modelArrayWithClass:[WordDataModel class] json:data[@"allWordsList"]];
        
        if (pagenumber == 1) {
            [self.fuzzyWordTableView.mj_header endRefreshing];
            [self.fuzzyWordTableView.mj_footer resetNoMoreData];
            
             self.datas = [NSMutableArray arrayWithArray:array];
        } else {
            [self.fuzzyWordTableView.mj_footer endRefreshing];
            [self.datas addObjectsFromArray:array];
        }
        
       
        [self.fuzzyWordTableView reloadData];
        
    }
    
    if ([(SFBaseApiRequest *)request isKindOfClass:[YHCollectWordApi class]]) {
        [SFHUD showInfoToast:obj[@"message"]];
    }
}

-(void)requestFailed:(__kindof YTKBaseRequest *)request {
    
}

- (void)getNewData {
    pagenumber = 0;
    self.datas = nil;
    YHMeWordsApi *api = [[YHMeWordsApi alloc] initWithPage:1 row:10 type:2 userId:[YHUserManager sharedManager].userId token:[YHUserManager sharedManager].token];
    api.delegate = self;
    pagenumber = 1;
    [api start];
}

- (void)getMoreData {
    pagenumber += 1;
    YHMeWordsApi *api  = [[YHMeWordsApi alloc] initWithPage:pagenumber row:10 type:2 userId:[YHUserManager sharedManager].userId token:[YHUserManager sharedManager].token];
    api.delegate = self;
    [api start];
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
    UITableViewRowAction *rememberAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"记住了" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        WordDataModel *model = self.datas[indexPath.row];
        NSLog(@"标记%@ 为模糊单词",model.word);
        YHMarkWordsApi *api = [[YHMarkWordsApi alloc] initWithType:3 token:[YHUserManager sharedManager].token userId:[YHUserManager sharedManager].userId wordId:model.wordId];
        api.delegate = self;
        [api start];
        [self.datas removeObjectAtIndex:indexPath.row];
        [self.fuzzyWordTableView reloadData];
    }];
    
    UITableViewRowAction *likeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
           WordDataModel *model = self.datas[indexPath.row];
           NSLog(@"收藏单词 %@",model.word);
             YHCollectWordApi *api = [[YHCollectWordApi alloc] initWithToken:[YHUserManager sharedManager].token userId:[YHUserManager sharedManager].userId wordId:model.wordId];
           api.delegate = self;
           [api start];
           [self.fuzzyWordTableView reloadData];
       }];
    
    return @[rememberAction,likeAction];
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
- (UITableView *)fuzzyWordTableView {
    if (!_fuzzyWordTableView) {
        _fuzzyWordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _fuzzyWordTableView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        _fuzzyWordTableView.showsVerticalScrollIndicator = NO;
        [_fuzzyWordTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [_fuzzyWordTableView registerClass:[YHWordTableViewCell class] forCellReuseIdentifier:[YHWordTableViewCell cellIdentifier]];
        
        _fuzzyWordTableView.delegate = self;
        _fuzzyWordTableView.dataSource = self;
    }
    return _fuzzyWordTableView;
}

- (NSMutableArray<WordDataModel *> *)datas {
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}

- (YHMeWordsApi *)fuzzyWordsApi {
    if (!_fuzzyWordsApi) {
        pagenumber += 1;
        _fuzzyWordsApi = [[YHMeWordsApi alloc] initWithPage:pagenumber row:10 type:2 userId:[YHUserManager sharedManager].userId token:[YHUserManager sharedManager].token];
        _fuzzyWordsApi.delegate = self;
    }
    return _fuzzyWordsApi;
}
@end
