//
//  UIView+SFAddLine.h
//  FootBath
//
//  Created by zhang on 2016/12/16.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SFAddLine)

- (UIView *)sf_line;

- (UIView *)sf_lineWithColor:(UIColor *)lineColor;

- (void)sf_addLineTop:(BOOL)hasTop bottom:(BOOL)hasBottom;

- (void)sf_addLineTop:(BOOL)hasTop bottom:(BOOL)hasBottom leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;

- (void)sf_addLineTop:(BOOL)hasTop bottom:(BOOL)hasBottom lineColor:(UIColor *)lineColor leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;

@end
