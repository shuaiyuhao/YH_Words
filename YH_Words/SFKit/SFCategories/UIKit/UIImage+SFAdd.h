//
//  UIImage+SFAdd.h
//  Pods
//
//  Created by zhang on 16/6/12.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (SFAdd)

+ (UIImage *)imageWithColor:(UIColor *)aColor;

+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

- (UIImage *)scaledToSize:(CGSize)targetSize;

- (UIImage *)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;

- (UIImage *)scaledToMaxSize:(CGSize )size;

@end
