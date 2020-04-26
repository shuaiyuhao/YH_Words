//
//  YHFavoriteWordController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/27.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHFavoriteWordController.h"

@interface YHFavoriteWordController ()

@property (nonatomic,strong) UITableView *favoriteWordTableView;

@end

@implementation YHFavoriteWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收藏单词";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
     [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
}



#pragma mark - getter and setter
#pragma mark -
- (UITableView *)favoriteWordTableView {
    if (!_favoriteWordTableView) {
        _favoriteWordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _favoriteWordTableView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        _favoriteWordTableView.showsVerticalScrollIndicator = NO;
        [_favoriteWordTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _favoriteWordTableView;
}

@end
