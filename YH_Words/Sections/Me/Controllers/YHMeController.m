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

@interface YHMeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIButton *testButton;
@property (nonatomic,strong) UICollectionView *meCollectionView;
@property (nonatomic,strong) UIView *headerView;

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
    [self.view addSubview:self.meCollectionView];
    
    [self layoutPageViews];
}


- (void)layoutPageViews {
//    [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
    
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
//        [cell configWithData:nil];
        
        return cell;
    } else if (indexPath.row == 1) {
        YHTodayDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHTodayDataCollectionViewCell cellIdentifier] forIndexPath:indexPath];
        
        [cell configWithData:@""];
        return cell;
    } else if (indexPath.row == 2) {
        YHTodayDataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YHTodayDataCollectionViewCell cellIdentifier] forIndexPath:indexPath];
        
        [cell configWithData:@""];
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
    
    return nil;
}


#pragma mark - getter and setter
#pragma mark -
- (UICollectionView *)meCollectionView {
    if (!_meCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 110);
        layout.minimumLineSpacing = 28;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(10, 30, 10, 30);
        
        _meCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _meCollectionView.backgroundColor = [UIColor colorWithHexString:@"0x171C24"];
        [_meCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"meCollectionViewHeader"];
        
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
@end
