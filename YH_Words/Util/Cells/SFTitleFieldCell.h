//
//  SFTitleFieldCell.h
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/17.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstant.h"
#import "SFBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN


@interface SFTitleFieldCell : SFBaseTableViewCell

@property (nonatomic,strong) UITextField *valueTextField;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,assign) NSInteger canWrite;

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

- (void)configWithData:(id)data;

- (void)layoutPageViews;

- (void)setTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder;

- (void)setBorderWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder;

- (void)setRightWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder;

- (void)setRightNoBorderWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder;

- (void)setValueTextFieldLeftPadding:(double)padding;

@property (nonatomic,strong) SFStringActionBlock stringBlock;

@property (nonatomic,assign) BOOL secureTextEntry;

@property (nonatomic,assign) UIKeyboardType keyboardType;

@property (nonatomic,assign) NSInteger limit;

@property (nonatomic,assign) BOOL isBank;

@property (nonatomic,assign) BOOL titileIsHidden;

@end

NS_ASSUME_NONNULL_END
