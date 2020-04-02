//
//  YHMeController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/31.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHMeController.h"
#import "YHLoginController.h"

@interface YHMeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIButton *testButton;
@property (nonatomic,strong) UICollectionView *meCollectionView;

@end

@implementation YHMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationItem.title = @"我的";
    self.navigationItem.title = @"我的";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
//    [self.view addSubview:self.testButton];
    
    [self layoutPageViews];
}


- (void)layoutPageViews {
//    [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
}

#pragma mark - UICollectionViewDelegate
#pragma mark -


#pragma mark - UICollectionViewDatasource
#pragma mark -


#pragma mark - getter and setter
#pragma mark -
- (UICollectionView *)meCollectionView {
    if (!_meCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _meCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _meCollectionView.backgroundColor = [UIColor colorWithHexString:@"0x171C24"];
        
        
        
        _meCollectionView.delegate = self;
        _meCollectionView.dataSource = self;
    }
    
    return +_meCollectionView;
   
}




- (UIButton *)testButton {
    if (!_testButton) {
        _testButton = UIButton.builder()
        .title(@"登陆界面测试")
        .titleColor([UIColor redColor])
        .font([UIFont systemFontOfSize:14])
        .build();
    }
//    WeakSelf;
//    [_testButton sf_addHandler:^(id weakSender) {
//
//        UIViewController *vc = [YHLoginController new];
//        [weakSelf.navigationController pushViewController:vc animated:true];
//    } forControlEvents:UIControlEventTouchUpInside];
    
    [_testButton addTarget:self action:@selector(testButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    return _testButton;
}

- (void)testButtonTapped {
    WeakSelf;
    
    UIViewController *vc = [YHLoginController new];
    [weakSelf.navigationController pushViewController:vc animated:true];
}
@end
