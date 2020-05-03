//
//  YHSettingController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/3.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHSettingController.h"
#import "YHMeSettingCell.h"
#import "SFTitleValueCell.h"

@interface YHSettingController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *settingTableView;

@end

@implementation YHSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
    [self.view addSubview:self.settingTableView];
    
}
#pragma mark - UITableViewViewDelegate
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [YHMeSettingCell cellHeight];
    } else {
        return [SFTitleValueCell cellHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

#pragma mark - UITableViewDataSource
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YHMeSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[YHMeSettingCell cellIdentifier] forIndexPath:indexPath];
        
        return cell;
    } else if (indexPath.section == 1) {
        SFTitleValueCell *cell = [tableView dequeueReusableCellWithIdentifier:[SFTitleValueCell cellIdentifier] forIndexPath:indexPath];
        
        [cell setImage:nil title:@"账户与安全" value:@""];
        return cell;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            SFTitleValueCell *cell = [tableView dequeueReusableCellWithIdentifier:[SFTitleValueCell cellIdentifier] forIndexPath:indexPath];
            
            [cell setImage:nil title:@"问题反馈" value:@""];
            return cell;
        } else if (indexPath.row == 1) {
            SFTitleValueCell *cell = [tableView dequeueReusableCellWithIdentifier:[SFTitleValueCell cellIdentifier] forIndexPath:indexPath];
            
            [cell setImage:nil title:@"关于我们" value:@""];
            return cell;
        }
    }
    return nil;
}
#pragma mark - getter and setter
#pragma mark -
- (UITableView *)settingTableView {
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _settingTableView.backgroundColor = [UIColor colorWithHexString:@"0x171C24"];
        
        [_settingTableView registerClass:[YHMeSettingCell class] forCellReuseIdentifier:[YHMeSettingCell cellIdentifier]];
        
        [_settingTableView registerClass:[SFTitleValueCell class] forCellReuseIdentifier:[SFTitleValueCell cellIdentifier]];
        
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
    }
    
    return _settingTableView;
}

@end