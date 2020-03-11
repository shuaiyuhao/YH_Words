//
//  UIButton+SFFly.m
//  CodeStudy
//
//  Created by zhang on 7/8/16.
//  Copyright © 2016 zhangliuliu. All rights reserved.
//

#import "UIButton+SFFly.h"
#import "UIImage+SFAdd.h"

@implementation UIButton (SFFly)

#pragma mark - 快速创建UIButton
#pragma mark -

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
          highlightTitleColor:(UIColor *)highlightTitleColor
              backgroundColor:(UIColor *)backgroundColor
     highlightBackgroundColor:(UIColor *)highlightBackgroundColor
                 cornerRadius:(CGFloat)cornerRadius{
    return [self buttonWithTitle:title titleColor:titleColor highlightTitleColor:highlightTitleColor backgroundColor:backgroundColor highlightBackgroundColor:highlightBackgroundColor font:nil cornerRadius:cornerRadius];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
          highlightTitleColor:(UIColor *)highlightTitleColor
              backgroundColor:(UIColor *)backgroundColor
     highlightBackgroundColor:(UIColor *)highlightBackgroundColor{
    return [self buttonWithTitle:title titleColor:titleColor highlightTitleColor:highlightTitleColor backgroundColor:backgroundColor highlightBackgroundColor:highlightBackgroundColor font:nil cornerRadius:0];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                         font:(UIFont *)font
                 cornerRadius:(CGFloat)cornerRadius{
    return [self buttonWithTitle:title titleColor:titleColor highlightTitleColor:nil backgroundColor:backgroundColor highlightBackgroundColor:nil font:font cornerRadius:cornerRadius];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                 cornerRadius:(CGFloat)cornerRadius{
    return [self buttonWithTitle:title titleColor:titleColor highlightTitleColor:nil backgroundColor:backgroundColor highlightBackgroundColor:nil font:nil cornerRadius:cornerRadius];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightTitleColor cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor highlightBackgroundColor:(UIColor *)highlightBackgroundColor{
    return [self buttonWithTitle:title titleColor:titleColor highlightTitleColor:highlightTitleColor backgroundColor:backgroundColor highlightBackgroundColor:highlightBackgroundColor font:nil cornerRadius:cornerRadius];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
          highlightTitleColor:(UIColor *)highlightTitleColor
              backgroundColor:(UIColor *)backgroundColor
     highlightBackgroundColor:(UIColor *)highlightBackgroundColor
                         font:(UIFont *)font
                 cornerRadius:(CGFloat)cornerRadius{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (highlightTitleColor) {
        [button setTitleColor:highlightTitleColor forState:UIControlStateHighlighted];
        [button setTitleColor:highlightTitleColor forState:UIControlStateSelected];
    }
    if (cornerRadius > 0) {
        button.layer.cornerRadius = cornerRadius;
        button.layer.masksToBounds = YES;
        button.clipsToBounds = YES;
    }
    if ((backgroundColor)) {
        [button setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:UIControlStateNormal];
    }
    if (highlightBackgroundColor) {
        [button setBackgroundImage:[UIImage imageWithColor:highlightBackgroundColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageWithColor:highlightBackgroundColor] forState:UIControlStateSelected];
    }
    if (font == nil) {
        font = [UIFont systemFontOfSize:15.f];
    }
    button.titleLabel.font = font;
    
    return button;
}

#pragma mark - 
#pragma mark -

+ (UIButton *)butttonWithImage:(UIImage *)image{
    return [self butttonWithImage:image highlightImage:nil title:nil titleColor:nil font:nil];
}

+ (UIButton *)butttonWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage{
    return [self butttonWithImage:image highlightImage:highlightImage title:nil titleColor:nil font:nil];
}

+ (UIButton *)butttonWithImage:(UIImage *)image title:(NSString *)title font:(UIFont *)font{
    return [self butttonWithImage:image highlightImage:nil title:title titleColor:nil font:nil];
}

+ (UIButton *)butttonWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage title:(NSString *)title font:(UIFont *)font{
    return [self butttonWithImage:image highlightImage:highlightImage title:title titleColor:nil font:font];
}

+ (UIButton *)butttonWithImage:(UIImage *)image
                highlightImage:(UIImage *)highlightImage
                         title:(NSString *)title
                    titleColor:(UIColor *)titleColor
                      font:(UIFont *)font{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    if (highlightImage) {
        [button setImage:highlightImage forState:UIControlStateHighlighted];
        [button setImage:highlightImage forState:UIControlStateSelected];
    }
    if ([title length]) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (font == nil) {
        font = [UIFont systemFontOfSize:14];
    }
    button.titleLabel.font = font;
    
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    return button;
}

@end
