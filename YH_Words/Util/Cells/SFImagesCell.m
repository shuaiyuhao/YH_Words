//
//  SFImagesCell.m
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/19.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import "SFImagesCell.h"
#import <Masonry.h>
#import "UITextField+SFBuilder.h"
#import "UILabel+SFBuilder.h"
#import "AppMacros.h"
#import "UILabel+SFFly.h"
#import "SFImageCCell.h"

@interface SFImagesCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *myCollectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@property (nonatomic,strong) NSArray<UIImage *> *imageArray;

@end

@implementation SFImagesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.myCollectionView];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(0);
        make.right.bottom.equalTo(self.contentView).offset(0);
    }];
}

+ (CGFloat)cellHeight{
    return 88.f;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)configWithData:(id)data {
    if(data && [data isKindOfClass:[NSArray class]]){
        self.imageArray = data;
        [self.myCollectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource
#pragma mark -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SFImageCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SFImageCCell cellIdentifier] forIndexPath:indexPath];
    if(indexPath.item == self.imageArray.count){
        [cell configWithData:nil];
    }else{
        [cell configWithData:[self.imageArray objectAtIndex:indexPath.item]];
    }
    WeakSelf;
    [cell setDeleteBlock:^{
        if(weakSelf.deleteBlock){
            weakSelf.deleteBlock(indexPath.item);
        }
    }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
#pragma mark -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if(indexPath.item == self.imageArray.count){
        if (self.addBlock) {
            self.addBlock();
        }
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - getter and setter
#pragma mark -
- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = [SFImageCCell cellSize];
        _layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        _layout.minimumLineSpacing = 16;
        _layout.minimumInteritemSpacing = 6;
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        [_myCollectionView registerClass:[SFImageCCell class] forCellWithReuseIdentifier:[SFImageCCell cellIdentifier]];
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
    }
    return _myCollectionView;
}

@end
