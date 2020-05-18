//
//  YHAccountSecurityController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/16.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHAccountSecurityController.h"
#import "SFTitleValueCell.h"

@interface YHAccountSecurityController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSArray *items;

@end

@implementation YHAccountSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户与安全";
       [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
       [self.navigationController.navigationBar setShadowImage:[UIImage new]];
       
       [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
       
    [self.view addSubview:self.myTableView];
     self.myTableView.scrollEnabled = NO;
}

#pragma mark - UITableViewDelegate
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = [self.items objectAtIndex:section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SFTitleValueCell cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        
    }else if(indexPath.row == 2){
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - UITableViewDataSource
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SFTitleValueCell *cell = [tableView dequeueReusableCellWithIdentifier:[SFTitleValueCell cellIdentifier] forIndexPath:indexPath];
    NSDictionary *dic = [[self.items objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.titleColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.canEdit = NO;
        cell.valueRightPadding = 16;
    }else{
        cell.canEdit = YES;
        cell.valueLeftPadding = 0;
    }
    [cell setImage:[UIImage imageNamed:dic[@"icon"]] title:dic[@"name"] value:dic[@"value"] placeholder:@""];
    
    if(indexPath.row){
           [cell sf_addLineTop:YES bottom:NO leftSpace:10 rightSpace:10];
       }else{
           [cell sf_addLineTop:NO bottom:NO];
       }
    return cell;
}

#pragma mark - getter and setter
#pragma mark -
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 195) style:UITableViewStyleGrouped];
            [tableView registerClass:[SFTitleValueCell class] forCellReuseIdentifier:[SFTitleValueCell cellIdentifier]];
            
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
            tableView.showsVerticalScrollIndicator = NO;
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            
            tableView;
        });
    }
    return _myTableView;
}

- (NSArray *)items {
        _items = @[
            @[
                @{@"icon":@"",@"name":@"用户名", @"value":[YHUserManager sharedManager].userName},
                @{@"icon":@"",@"name":@"修改手机号"},
                @{@"icon":@"",@"name":@"修改登录密码"},
                @{@"icon":@"",@"name":@"注销账户"},
            ],
            
        ];
    return _items;
}

@end
