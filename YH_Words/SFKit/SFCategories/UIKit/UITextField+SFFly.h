//
//  UITextField+SFFly.h
//  CodeStudy
//
//  Created by zhang on 7/11/16.
//  Copyright © 2016 zhangliuliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SFFly)

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame;

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder font:(UIFont *)font textColor:(UIColor *)textColor;

+ (UITextField *)textFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor ;

@end
