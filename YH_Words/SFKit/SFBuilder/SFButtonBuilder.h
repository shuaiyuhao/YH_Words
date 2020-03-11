//
//  SFButtonBuilder.h
//  SFKit_Example
//
//  Created by liuliu zhang on 2018/6/6.
//  Copyright © 2018年 zll19911011@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFButtonBuilder : NSObject

- (SFButtonBuilder *(^)(NSString *))title;

- (SFButtonBuilder *(^)(UIColor *))titleColor;

- (SFButtonBuilder *(^)(UIColor *))highlightedTitleColor;

- (SFButtonBuilder *(^)(UIFont *))font;

- (SFButtonBuilder *(^)(CGFloat))fontSize;

- (SFButtonBuilder *(^)(CGFloat))cornerRadius;

- (SFButtonBuilder *(^)(UIColor *))backgroundColor;

- (SFButtonBuilder *(^)(UIColor *))highlightedBackgroundColor;

- (SFButtonBuilder *(^)(UIColor *))disabledBackgroundColor;

- (SFButtonBuilder *(^)(UIColor *))borderColor;

- (SFButtonBuilder *(^)(CGFloat))borderWidth;

- (SFButtonBuilder *(^)(UIImage *))image;

- (SFButtonBuilder *(^)(UIImage *))highlightedImage;

- (SFButtonBuilder *(^)(UIImage *))selectedImage;

- (UIButton *(^) (void))build;

@end
