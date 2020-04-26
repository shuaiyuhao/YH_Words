//
//  YHFuzzyWordController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/27.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHFuzzyWordController.h"

@interface YHFuzzyWordController ()

@property (nonatomic,strong) UITableView *fuzzyWordTableView;

@end

@implementation YHFuzzyWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"模糊单词";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
     [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
}


#pragma mark - getter and setter
#pragma mark -
- (UITableView *)fuzzyWordTableView {
    if (!_fuzzyWordTableView) {
        _fuzzyWordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _fuzzyWordTableView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        _fuzzyWordTableView.showsVerticalScrollIndicator = NO;
        [_fuzzyWordTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _fuzzyWordTableView;
}

@end
