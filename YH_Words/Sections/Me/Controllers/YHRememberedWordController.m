//
//  YHRememberedWordController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/27.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHRememberedWordController.h"

@interface YHRememberedWordController ()

@property (nonatomic,strong) UITableView *rememberedWordTableView;

@end

@implementation YHRememberedWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"已记忆单词";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
       
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
}





#pragma mark - getter and setter
#pragma mark -
- (UITableView *)rememberedWordTableView {
    if (!_rememberedWordTableView) {
        _rememberedWordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _rememberedWordTableView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        _rememberedWordTableView.showsVerticalScrollIndicator = NO;
        [_rememberedWordTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _rememberedWordTableView;
}
@end
