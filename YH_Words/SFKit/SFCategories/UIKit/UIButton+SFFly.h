//
//  UIButton+SFFly.h
//  CodeStudy
//
//  Created by zhang on 7/8/16.
//  Copyright © 2016 zhangliuliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SFFly)

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
          highlightTitleColor:(UIColor *)highlightTitleColor
              backgroundColor:(UIColor *)backgroundColor
     highlightBackgroundColor:(UIColor *)highlightBackgroundColor
                         font:(UIFont *)font
                 cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
          highlightTitleColor:(UIColor *)highlightTitleColor
              backgroundColor:(UIColor *)backgroundColor
     highlightBackgroundColor:(UIColor *)highlightBackgroundColor
                 cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
          highlightTitleColor:(UIColor *)highlightTitleColor
              backgroundColor:(UIColor *)backgroundColor
     highlightBackgroundColor:(UIColor *)highlightBackgroundColor;

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                         font:(UIFont *)font
                 cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                 cornerRadius:(CGFloat)cornerRadius;



+ (UIButton *)butttonWithImage:(UIImage *)image;

+ (UIButton *)butttonWithImage:(UIImage *)image
                highlightImage:(UIImage *)highlightImage;

+ (UIButton *)butttonWithImage:(UIImage *)image
                         title:(NSString *)title
                          font:(UIFont *)font;

+ (UIButton *)butttonWithImage:(UIImage *)image
                highlightImage:(UIImage *)highlightImage
                         title:(NSString *)title
                          font:(UIFont *)font;

+ (UIButton *)butttonWithImage:(UIImage *)image
                highlightImage:(UIImage *)highlightImage
                         title:(NSString *)title
                    titleColor:(UIColor *)titleColor
                          font:(UIFont *)font;
//---------------------------------------------------------------------------------------//

@end
