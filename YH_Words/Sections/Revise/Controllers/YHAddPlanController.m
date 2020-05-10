//
//  YHAddPlanController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/30.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHAddPlanController.h"
#import "SFTitleFieldCell.h"
#import "YHAddPlanCell.h"


@interface YHAddPlanController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *addPlanTableView;

@property (nonatomic,strong) UIBarButtonItem *doneButton;

@property (nonatomic,strong) YHPlanModel *planModel;

@property (nonatomic,strong) NSString *str;

@end

@implementation YHAddPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    self.navigationItem.title = @"添加计划";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.rightBarButtonItem = self.doneButton;
    
    [self.view addSubview:self.addPlanTableView];
}

#pragma mark - UITableViewDelegate
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [YHAddPlanCell cellHeight];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHAddPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHAddPlanCell cellIdentifier] forIndexPath:indexPath];;
    [cell sf_addLineTop:NO bottom:YES lineColor:[UIColor grayColor] leftSpace:10 rightSpace:10];
    
    [cell setTextChangeBlock:^(NSString *index) {
        self.str = index;
    }];
    
    NSLog(@"%@",self.planModel);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tableView reloadData];
}
#pragma mark - getter and setter
#pragma mark -
- (UITableView *)addPlanTableView {
    if (!_addPlanTableView) {
        _addPlanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        
        _addPlanTableView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        _addPlanTableView.showsVerticalScrollIndicator = NO;
        [_addPlanTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [_addPlanTableView registerClass:[YHAddPlanCell class] forCellReuseIdentifier:[YHAddPlanCell cellIdentifier]];
        
        _addPlanTableView.delegate = self;
        _addPlanTableView.dataSource = self;
    }
    return _addPlanTableView;
}

- (UIBarButtonItem *)doneButton {
    if (!_doneButton) {
        _doneButton = [UIBarButtonItem new];
        _doneButton.title = @"确定";
        
        _doneButton.target = self;
        _doneButton.action = @selector(doneButtonTapped);
        
    }
    return _doneButton;
}

- (void)doneButtonTapped {
    if ([self.planDelegate respondsToSelector:@selector(transferPlan:controller:)]) {
        self.planModel.plan = self.str;
        
        [self.planDelegate transferPlan:self.planModel controller:self];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (YHPlanModel *)planModel {
    if (!_planModel) {
        _planModel = [YHPlanModel new];
    }
    return _planModel;
}
@end
