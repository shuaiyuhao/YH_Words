//
//  NSMutableAttributedString+SFCalSize.h
//  Pods
//
//  Created by zhang on 16/6/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (SFCalSize)

- (CGSize)getSizeWithConstrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithConstrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithConstrainedToSize:(CGSize)size;

- (CGFloat)getHeightWithConstrainedToSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;

@end
