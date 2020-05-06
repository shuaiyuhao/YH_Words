//
//  YHAddPlanController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/30.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHAddPlanController.h"
#import "SFTitleFieldCell.h"

@interface YHAddPlanController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *addPlanTableView;

@end

@implementation YHAddPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    self.navigationItem.title = @"添加计划";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    [self.view addSubview:self.addPlanTableView];
}

#pragma mark - getter and setter
#pragma mark -
- (UITableView *)addPlanTableView {
    if (!_addPlanTableView) {
        _addPlanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        
        _addPlanTableView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        _addPlanTableView.showsVerticalScrollIndicator = NO;
        [_addPlanTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [_addPlanTableView registerClass:[SFTitleFieldCell class] forCellReuseIdentifier:[SFTitleFieldCell cellIdentifier]];
        
        _addPlanTableView.delegate = self;
        _addPlanTableView.dataSource = self;
    }
    return _addPlanTableView;
}

@end
