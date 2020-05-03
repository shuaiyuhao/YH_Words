//
//  SFTitleValueMoreCell.h
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/8/22.
//  Copyright © 2019 xiaohuodui-2. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFTitleValueMoreCell : UITableViewCell

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

- (void)configWithData:(id)data;

- (void)setTitle:(NSString *)title value:(NSString *)value;

- (void)setTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
