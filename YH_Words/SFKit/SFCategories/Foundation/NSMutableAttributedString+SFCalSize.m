//
//  NSMutableAttributedString+SFCalSize.m
//  Pods
//
//  Created by zhang on 16/6/12.
//
//

#import "NSMutableAttributedString+SFCalSize.h"

@implementation NSMutableAttributedString (SFCalSize)

- (CGSize)getSizeWithConstrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        resultSize=[self boundingRectWithSize:size options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
    }
    resultSize = CGSizeMake(ceil(resultSize.width),ceil(resultSize.height));
    
    return resultSize;
}

- (CGFloat)getHeightWithConstrainedToSize:(CGSize)size{
    return [self getSizeWithConstrainedToSize:size].height;
}

- (CGFloat)getWidthWithConstrainedToSize:(CGSize)size{
    return [self getSizeWithConstrainedToSize:size].width;
}

- (CGFloat)getHeightWithConstrainedToSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    [self addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
    [self addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    
    return [self getHeightWithConstrainedToSize:size];
}

@end
