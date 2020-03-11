//
//  UITextField+SFFly.m
//  CodeStudy
//
//  Created by zhang on 7/11/16.
//  Copyright © 2016 zhangliuliu. All rights reserved.
//

#import "UITextField+SFFly.h"

@implementation UITextField (SFFly)

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    textField.textColor = textColor;
    textField.placeholder = placeHolder;
    textField.font = font;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return textField;
}

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeHolder font:(UIFont *)font textColor:(UIColor *)textColor{
    return [self textFieldWithPlaceHolder:placeHolder font:font textColor:textColor frame:CGRectZero];
}

+ (UITextField *)textFieldWithFont:(UIFont *)font textColor:(UIColor *)textColor{
    return [self textFieldWithPlaceHolder:nil font:font textColor:textColor frame:CGRectZero];
}

@end
