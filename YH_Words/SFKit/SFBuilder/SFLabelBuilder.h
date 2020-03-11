//
//  SFLabelBuilder.h
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFLabelBuilder : NSObject

- (SFLabelBuilder *(^)(NSString *))text;

- (SFLabelBuilder *(^)(UIColor *))textColor;

- (SFLabelBuilder *(^)(UIColor *))backgroundColor;

- (SFLabelBuilder *(^)(UIFont *))font;

- (SFLabelBuilder *(^)(CGFloat))fontSize;

- (SFLabelBuilder *(^)(NSTextAlignment))textAlignment;

- (SFLabelBuilder *(^)(CGFloat))numberOfLines;

- (SFLabelBuilder *(^)(NSString *))boldSubstring;

- (SFLabelBuilder *(^)(NSRange))boldRange;

- (SFLabelBuilder *(^)(NSString *, UIColor *))colorSubstring;

- (SFLabelBuilder *(^)(NSRange, UIColor *))colorRange;

/// 删除线
- (SFLabelBuilder *(^)(NSRange, UIColor *))strikeLineRange;

/**
 字间距
 */
- (SFLabelBuilder *(^)(CGFloat))kernSpacing;

/**
 行间距
 */
- (SFLabelBuilder *(^)(CGFloat))lineSpacing;

- (UILabel *(^)(void))build;

@end
