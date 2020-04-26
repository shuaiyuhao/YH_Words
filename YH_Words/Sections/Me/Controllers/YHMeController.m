//
//  YHMeController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/31.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHMeController.h"
#import "YHLoginController.h"
#import "YHButtonCollectionViewCell.h"
#import "YHTodayDataCollectionViewCell.h"
#import "YHTodayBrowseCell.h"
#import "YHRememberedWordController.h"
#import "YHFuzzyWordController.h"
#import "YHFavoriteWordController.h"

@interface YHMeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *meCollectionView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,strong) NSArray *buttonArray;
@end

@implementation YHMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationItem.title = @"我的";
    self.navigationItem.title = @"我的";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
    [self.view addSubview:self.meCollectionView];
    
    [self layoutPageViews];
}


- (void)layoutPageViews {
    [self.meCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UICollectionViewDelegate
#pragma mark -


#pragma mark - UICollectionViewDatasource
#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YHButtonCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:[YHButtonCollectionViewCell cellIdentifier] forIndexPath:indexPath];
        [cell configWithData:self.buttonArray];
        
        [cell setButton1TappedBlock:^{
            YHRememberedWordController *vc = [YHRememberedWordController new];
            [self.navigationController pushViewController:vc animated:true];
        }];
        
        [cell setButton2TappedBlock:^{
            YHFuzzyWordController *vc = [YHFuzzyWordController new];
            [self.navigationController pushViewController:vc animated:true];
        }];
        
        [cell setButton3TappedBlock:^{
            YHFavoriteWordController *vc = [YHFavoriteWordController new];
            [self.navigationController pushViewController:vc animated:true];
        }];
        
        return cell;
    } else if (indexPath.row == 1) {
        YHTodayDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHTodayDataCollectionViewCell cellIdentifier] forIndexPath:indexPath];
        
        [cell configTitle:@"今日浏览"];
        return cell;
    } else if (indexPath.row == 2) {
        YHTodayDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHTodayDataCollectionViewCell cellIdentifier] forIndexPath:indexPath];
        
        [cell configTitle:@"今日模糊"];
        return cell;
    } else {
        YHTodayBrowseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHTodayBrowseCell cellIdentifier] forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [YHButtonCollectionViewCell cellSize];
    } else if (indexPath.row == 1) {
        return [YHTodayDataCollectionViewCell cellSize];
    } else if (indexPath.row == 2) {
        return [YHTodayDataCollectionViewCell cellSize];
    } else {
        return [YHTodayBrowseCell cellSize];
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"meCollectionViewHeader" forIndexPath:indexPath];
        for (UIView *view1 in view.subviews) {
            [view1 removeFromSuperview];
        }
        
        [view addSubview:self.headerView];
        return view;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"meCollectionViewFooter" forIndexPath:indexPath];
        for (UIView *view1 in view.subviews) {
            [view1 removeFromSuperview];
        }
        
        [view addSubview:self.footerView];
        return view;
        
    }
    
    return nil;
}


#pragma mark - getter and setter
#pragma mark -
- (UICollectionView *)meCollectionView {
    if (!_meCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 110);
        layout.footerReferenceSize = CGSizeMake(kScreenWidth, 80);
        layout.minimumLineSpacing = 28;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10, 30, 40, 30);
        
        _meCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _meCollectionView.backgroundColor = [UIColor colorWithHexString:@"0x171C24"];
        [_meCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"meCollectionViewHeader"];
        [_meCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"meCollectionViewFooter"];
        
        [_meCollectionView registerClass:[YHButtonCollectionViewCell class] forCellWithReuseIdentifier:[YHButtonCollectionViewCell cellIdentifier]];
        [_meCollectionView registerClass:[YHTodayDataCollectionViewCell class] forCellWithReuseIdentifier:[YHTodayDataCollectionViewCell cellIdentifier]];
         [_meCollectionView registerClass:[YHTodayBrowseCell class] forCellWithReuseIdentifier:[YHTodayBrowseCell cellIdentifier]];
        
        _meCollectionView.showsHorizontalScrollIndicator = NO;
        _meCollectionView.delegate = self;
        _meCollectionView.dataSource = self;
    }
    
    return _meCollectionView;
    
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
        _headerView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        
        UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 95, 95)];
        avatarView.image = [UIImage imageNamed:@"ic_user"];
        avatarView.contentMode = UIViewContentModeScaleAspectFill;
        avatarView.layer.cornerRadius = 40;
        
        [_headerView addSubview:avatarView];
        
        [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headerView);
            make.bottom.equalTo(self.headerView);
        }];
    }
    
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _footerView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        
        UIButton *logoutButton = UIButton.builder()
        .backgroundColor([UIColor colorWithHexString:@"ff003d"])
        .title(@"退出登录")
        .titleColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:24])
        .build();
        
        logoutButton.layer.cornerRadius = 10;
        
        logoutButton.layer.masksToBounds = YES;
        [self.footerView addSubview:logoutButton];
        
        [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(310, 48));
            make.center.equalTo(self.footerView);
        }];
    }
    return _footerView;
}

- (NSArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = @[
            @{
                @"title":@"记忆单词",
                @"image":@"ic_smile"
            },
            @{
                @"title":@"模糊单词",
                @"image":@"ic_cry"
            },
            
            @{
                @"title":@"收藏单词",
                @"image":@"ic_like"
            },
            
        ];
    }
    return _buttonArray;
}
@end
