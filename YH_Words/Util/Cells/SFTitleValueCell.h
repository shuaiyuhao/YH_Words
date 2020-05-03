//
//  SFTitleValueCell.h
//  FootBath
//
//  Created by zhang on 2016/12/21.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFBaseTableViewCell.h"

@interface SFTitleValueCell : SFBaseTableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *valueLabel;
//@property (nonatomic,assign) BOOL canEdit;
//
//@property (nonatomic,assign) BOOL canSelect;

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

- (void)setRightIcon:(UIImage *)image;

- (void)setRightIcon:(UIImage *)image size:(CGSize)size;

- (void)setImage:(id)image title:(NSString *)title value:(NSString *)value;
- (void)setImage:(id)image title:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder;

- (void)setImage:(id)image title:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder size:(CGSize)size;

- (void)setLeftImage:(id)image title:(NSString *)title value:(NSString *)value;

@property (nonatomic,assign) NSInteger titleLeftPadding;
@property (nonatomic,assign) NSInteger valueRightPadding;
@property (nonatomic,assign) NSInteger imageRightPadding;
@property (nonatomic,assign) NSInteger valueLeftPadding;

@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIFont *titleFont;

@property (nonatomic,strong) UIColor *valueColor;
@property (nonatomic,strong) UIFont *valueFont;

@end
