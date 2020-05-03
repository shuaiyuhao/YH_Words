//
//  SFImageCCell.h
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/19.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstant.h"
NS_ASSUME_NONNULL_BEGIN

@interface SFImageCCell : UICollectionViewCell

+ (CGSize)cellSize;

+ (NSString *)cellIdentifier;

- (void)configWithData:(id)data;

@property (nonatomic,strong) SFVoidActionBlock deleteBlock;

@end

NS_ASSUME_NONNULL_END
