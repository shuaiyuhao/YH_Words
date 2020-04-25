//
//  YHReviseController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/31.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHReviseController.h"

@interface YHReviseController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *reviseTableView;

@end

@implementation YHReviseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    self.navigationItem.title = @"复习计划";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark - UITableViewDelegate
#pragma mark -

#pragma mark - UITableViewDataSource
#pragma mark -


#pragma mark - getter and setter
#pragma mark -
- (UITableView *)reviseTableView {
    if (!_reviseTableView) {
        _reviseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    }
    
    return _reviseTableView;
}
@end
