//
//  SFTextFieldBuilder.h
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFTextFieldBuilder : NSObject

- (SFTextFieldBuilder *(^)(NSString *))text;

- (SFTextFieldBuilder *(^)(UIColor *))textColor;

- (SFTextFieldBuilder *(^)(NSString *))placeholder;

- (SFTextFieldBuilder *(^)(UIFont *))font;

- (SFTextFieldBuilder *(^)(CGFloat))fontSize;

- (SFTextFieldBuilder *(^)(CGFloat))cornerRadius;

- (SFTextFieldBuilder *(^)(UIColor *))borderColor;

- (SFTextFieldBuilder *(^)(CGFloat))borderWidth;

- (SFTextFieldBuilder *(^)(UIColor *))backgroundColor;

- (SFTextFieldBuilder *(^)(UIKeyboardType))keyboardType;

- (SFTextFieldBuilder *(^)(UITextFieldViewMode))clearButtonMode;

- (SFTextFieldBuilder *(^)(UIView *))leftView;

- (SFTextFieldBuilder *(^)(UIView *))rightView;

- (SFTextFieldBuilder *(^)(UIImage *, CGSize))leftImage;

- (SFTextFieldBuilder *(^)(CGFloat))leftPadding;

- (SFTextFieldBuilder *(^)(CGFloat))rightPadding;

- (UITextField *(^)(void))build;

@end
