//
//  YHButtonCollectionViewCell.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/21.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHBaseCollectionViewCell.h"
#import "AppConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHButtonCollectionViewCell : YHBaseCollectionViewCell

+ (CGSize)cellSize;

- (void)configWithData:(id)data;

@property (nonatomic,strong) SFVoidActionBlock button1TappedBlock;

@property (nonatomic,strong) SFVoidActionBlock button2TappedBlock;

@property (nonatomic,strong) SFVoidActionBlock button3TappedBlock;

@end

NS_ASSUME_NONNULL_END
