//
//  SFTitleValueCopyCell.h
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/19.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFTitleValueCopyCell : UITableViewCell

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

- (void)configWithData:(id)data;

- (void)setTitle:(NSString *)title value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
