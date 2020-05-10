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
#import "YHAddPlanController.h"

@interface YHReviseController ()<UITableViewDelegate, UITableViewDataSource, planDelegate>

@property (nonatomic,strong) UITableView *reviseTableView;

@property (nonatomic,strong) UIBarButtonItem *addButton;

@property (nonatomic,strong) NSArray<WordDataModel *> *datas;

@property (nonatomic,strong) NSMutableArray<YHPlanModel *> *plans;

@property (nonatomic,strong) NSString *planString;

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

#pragma mark - planStrDelegate
#pragma mark -
- (void)transferPlan:(YHPlanModel *)plan controller:(UIViewController *)vc {
    YHPlanModel *model = plan;
    
    [self.plans addObject:model];
    [self.reviseTableView reloadData];
    
    [vc.navigationController popViewControllerAnimated:true];
}

#pragma mark - UITableViewDataSource
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.plans.count;
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
        
        _addButton.target = self;
        _addButton.action = @selector(addButtonTapped);
    }
    return _addButton;
}

- (void)addButtonTapped {
    YHAddPlanController *vc = [YHAddPlanController new];
    
    vc.planDelegate = self;
    
    WeakSelf;
    [weakSelf.navigationController pushViewController:vc animated:true];
}

- (NSMutableArray<YHPlanModel *> *)plans {
    
    if (!_plans) {
        _plans = [NSMutableArray new];
    }
    return _plans;
}
@end
