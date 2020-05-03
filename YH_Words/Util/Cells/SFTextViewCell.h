//
//  SFTextViewCell.h
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/19.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstant.h"
NS_ASSUME_NONNULL_BEGIN

@interface SFTextViewCell : UITableViewCell

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

- (void)configWithData:(id)data;

- (void)setTitle:(NSString *)title placeholder:(NSString *)placeholder;

- (void)setBorderWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

- (void)setTextViewText:(NSString *)text;

@property (nonatomic,strong) SFStringActionBlock stringBlock;
@property (nonatomic,assign) BOOL textViewCanEdit;

@end

NS_ASSUME_NONNULL_END
