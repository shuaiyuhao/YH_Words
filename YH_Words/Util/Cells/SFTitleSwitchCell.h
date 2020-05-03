//
//  SFTitleSwitchCell.h
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/19.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface SFTitleSwitchCell : SFBaseTableViewCell

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

- (void)configWithData:(id)data;

- (void)setTitle:(NSString *)title status:(BOOL)status;

@property (nonatomic,strong) SFIndexActionBlock indexBlock;

- (void)configWithOn:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
