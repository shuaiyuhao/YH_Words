//
//  YHReviseController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/31.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHReviseController.h"
#import "WordDataModel.h"
#import "YHWordTableViewCell.h"
#import "YHPlanCell.h"
#import "YHPlanModel.h"

@interface YHReviseController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *reviseTableView;

@property (nonatomic,strong) UIBarButtonItem *addButton;

@property (nonatomic,strong) NSArray<WordDataModel *> *datas;

@property (nonatomic,strong) NSMutableArray<YHPlanModel *> *plans;

@end

@implementation YHReviseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    self.navigationItem.title = @"复习计划";
    self.navigationItem.rightBarButtonItem = self.addButton;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view addSubview:self.reviseTableView];
}

#pragma mark - UITableViewDelegate
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YHPlanCell cellHeight];
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
#pragma mark - UITableViewDataSource
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHPlanCell cellIdentifier] forIndexPath:indexPath];
    
    NSArray *arr = self.plans;
    
    YHPlanModel *model = arr[indexPath.row];
    
//    NSLog(@"%@",arr);
    
    [cell configWithPlan:model.plan planDone:model.isDone];
    
    [cell sf_addLineTop:NO bottom:YES lineColor:[UIColor grayColor] leftSpace:10 rightSpace:10];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YHPlanModel *model = self.plans[indexPath.row];
    model.isDone = !model.isDone;
    
    [tableView reloadData];
}
#pragma mark - getter and setter
#pragma mark -
- (UITableView *)reviseTableView {
    if (!_reviseTableView) {
        _reviseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _reviseTableView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        _reviseTableView.showsVerticalScrollIndicator = NO;
        [_reviseTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [_reviseTableView registerClass:[YHWordTableViewCell class] forCellReuseIdentifier:[YHWordTableViewCell cellIdentifier]];
        [_reviseTableView registerClass:[YHPlanCell class] forCellReuseIdentifier:[YHPlanCell cellIdentifier]];
        
        _reviseTableView.delegate = self;
        _reviseTableView.dataSource = self;
    }
    
    return _reviseTableView;
}

- (UIBarButtonItem *)addButton {
    if (!_addButton) {
        _addButton = [UIBarButtonItem new];
        _addButton.title = @"添加";
    }
    return _addButton;
}

- (NSArray<WordDataModel *> *)datas {
    if (!_datas) {
        _datas = @[
            [[WordDataModel alloc] initWithDic:@{
                @"word":@"abandon",
                @"phonetic":@"/ə'bændən/",
                @"chinese":@"v./抛弃，舍弃，放弃",
                @"example":@"We had to abandon the car and walk the rest of the way."
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"able",
                @"phonetic":@"/'eɪbəl/",
                @"chinese":@"a./能够；有能力的 be able to do",
                @"example":@"Will she be able to cope with the work?"
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"abnormal",
                @"phonetic":@"/æb'nɔːməl US -'nɔːr-/",
                @"chinese":@"a./反常的，变态的",
                @"example":@"abnormal behaviour"
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"abolish",
                @"phonetic":@"/ə'bɔlɪʃ US ə'bɑː-/",
                @"chinese":@"v./废除，废止",
                @"example":@"Slavery was abolished in the US in the 19th century."
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"about",
                @"phonetic":@"/ə'baut/",
                @"chinese":@"ad./大约；到处；四处# prep./关于；在各处；四处 ",
                @"example":@"We're about (= almost) ready to leave"
            }],

            [[WordDataModel alloc] initWithDic:@{
                @"word":@"absent",
                @"phonetic":@"/'æbsənt/",
                @"chinese":@"a./缺席，不在",
                @"example":@"`Nothing,' Rosie said in an absent way."
            }]


        ];
    }
    return _datas;
}

- (NSMutableArray<YHPlanModel *> *)plans {
    
    if (!_plans) {
        _plans = [NSMutableArray new];
        
        YHPlanModel *model0 = [[YHPlanModel alloc] initWithString:@"复习第一章"];
        
        YHPlanModel *model1 = [[YHPlanModel alloc] initWithString:@"复习第二章"];
        
        YHPlanModel *model2 = [[YHPlanModel alloc] initWithString:@"复习第三章"];
        
        YHPlanModel *model3 = [[YHPlanModel alloc] initWithString:@"复习第四章"];
        
        YHPlanModel *model4 = [[YHPlanModel alloc] initWithString:@"复习第五章"];
        
        [_plans addObject:model0];
        [_plans addObject:model1];
        [_plans addObject:model2];
        [_plans addObject:model3];
        [_plans addObject:model4];

    }
    return _plans;
}
@end
