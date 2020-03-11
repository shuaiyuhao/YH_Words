//
//  UITextView+SFPlaceholder.h
//  Pods
//
//  Created by zhang on 16/6/12.
//
//

#import <UIKit/UIKit.h>

@interface UITextView (SFPlaceholder)

@property (nonatomic, readonly) UILabel            *placeholderLabel;

@property (nonatomic, strong  ) NSString           *placeholder;
@property (nonatomic, strong  ) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong  ) UIColor            *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end
