//
//  UIImageView+SFFly.m
//  Pods
//
//  Created by zhang on 2016/12/11.
//
//

#import "UIImageView+SFFly.h"

@implementation UIImageView (SFFly)

+ (UIImageView *)imageViewWithImage:(UIImage *)image{
    return [self imageViewWithImage:image highlightImage:nil backgroundColor:nil cornerRadius:0];
}

+ (UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius{
    return [self imageViewWithImage:nil highlightImage:nil backgroundColor:backgroundColor cornerRadius:cornerRadius];
}

+ (UIImageView *)imageViewWithImage:(UIImage *)image backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius{
    return [self imageViewWithImage:image highlightImage:nil backgroundColor:backgroundColor cornerRadius:cornerRadius];
}

+ (UIImageView *)imageViewWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius{
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    if (image) {
        [imageView setImage:image];
    }
    if (highlightImage) {
        [imageView setHighlightedImage:highlightImage];
    }
    if (backgroundColor) {
        imageView.backgroundColor = backgroundColor;
    }
    if (cornerRadius > 0) {
        imageView.layer.cornerRadius = cornerRadius;
    }
    
    return imageView;
}

@end
