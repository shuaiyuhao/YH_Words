//
//  UIImageView+SFFly.h
//  Pods
//
//  Created by zhang on 2016/12/11.
//
//

#import <UIKit/UIKit.h>

@interface UIImageView (SFFly)

+ (UIImageView *)imageViewWithImage:(UIImage *)image;

+ (UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

+ (UIImageView *)imageViewWithImage:(UIImage *)image backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

+ (UIImageView *)imageViewWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

@end
