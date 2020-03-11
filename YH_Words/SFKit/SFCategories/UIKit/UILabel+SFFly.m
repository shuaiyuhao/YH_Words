//
//  UILabel+SFFly.m
//  CodeStudy
//
//  Created by zhang on 7/8/16.
//  Copyright © 2016 zhangliuliu. All rights reserved.
//

#import "UILabel+SFFly.h"

@implementation UILabel (SFFly)

#pragma mark - 快速新建UILabel
#pragma mark -

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = textAlignment;
//    label.backgroundColor = [UIColor whiteColor];
    label.opaque = YES;
    label.alpha = 1;
    label.numberOfLines = numberOfLines;

    return label;;
}

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize numberOfLines:(NSInteger)numberOfLines{
    return [self labelWithText:text textColor:color fontSize:fontSize numberOfLines:numberOfLines textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize{
    return [self labelWithText:text textColor:color fontSize:fontSize numberOfLines:1 textAlignment:NSTextAlignmentLeft];
}
+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color{
    return [self labelWithText:text textColor:color fontSize:[UIFont systemFontSize] numberOfLines:1 textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithTextColor:(UIColor *)color fontSize:(CGFloat)fontSize{
    return [self labelWithText:nil textColor:color fontSize:fontSize numberOfLines:1 textAlignment:NSTextAlignmentLeft];
}

#pragma mark - 对UILabel 进行加粗处理了
#pragma mark -
- (void)boldRange:(NSRange)range{
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    [attributedText addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font.pointSize]} range:range];
    
    self.attributedText = attributedText;
}

-(void)boldSubstring:(NSString*)substring{
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range];
}

#pragma mark – Color Label
#pragma mark -

- (void)colorSubstring:(NSString *)substring newColor:(UIColor *)color{
    NSRange range = [self.text rangeOfString:substring];
    
    [self colorRange:range newColor:color];
}

- (void)colorRange:(NSRange)range newColor:(UIColor *)color{
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    
    [attributedText addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    
    self.attributedText = attributedText;
}

#pragma mark - Font label
#pragma mark -

- (void)fontSubstring:(NSString *)substring newFont:(UIFont *)font{
    NSRange range = [self.text rangeOfString:substring];
    [self fontRange:range newFont:font];
}

- (void)fontRange:(NSRange)range newFont:(UIFont *)font{
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    
    [attributedText addAttributes:@{NSFontAttributeName:font} range:range];
    
    self.attributedText = attributedText;
}

#pragma mark – Bold and ColorLabel

- (void) boldColorSubstring: (NSString *) substring newColor:(UIColor *)color{
    NSRange range = [self.text rangeOfString:substring];
    
    [self boldColorRange:range newColor:color];
}

- (void) boldColorRange: (NSRange) range newColor:(UIColor *)color{
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    [attributedText addAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont boldSystemFontOfSize:self.font.pointSize]} range:range];
    
    self.attributedText = attributedText;
    
}

- (void)strikeLineRange:(NSRange)range color:(UIColor *)color {
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    
    NSMutableDictionary *att = [NSMutableDictionary dictionaryWithDictionary:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
    if (color) {
        att[NSStrikethroughColorAttributeName] = color;
    }
    
    [attributedText addAttributes:att range:range];
    
    self.attributedText = attributedText;
}

- (void)strikeLine {
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    
    NSMutableDictionary *att = [NSMutableDictionary dictionaryWithDictionary:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
    
    [attributedText addAttributes:att range:NSMakeRange(0, attributedText.length)];
    
    self.attributedText = attributedText;
}

#pragma mark - 调整字间距
#pragma mark -

- (void)adjustKernWithSpacing:(CGFloat)spacing{
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    [attributedText addAttribute:NSKernAttributeName
                           value:@(spacing)
                           range:NSMakeRange(0, attributedText.length)];
    
    self.attributedText = attributedText;
}

- (void)adjustKernWithSpacing:(CGFloat)spacing range:(NSRange)range{
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    [attributedText addAttribute:NSKernAttributeName
                             value:@(spacing)
                             range:range];
    
    self.attributedText = attributedText;
}

#pragma mark - 调整行间距
#pragma mark -

- (void)adjustLineSpacingWithSpacing:(CGFloat)lineSpacing{
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    NSMutableAttributedString *attributedText;
    
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc] init];
    style.alignment = self.textAlignment;
    style.lineSpacing=lineSpacing;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributedText.length)];
    
    self.attributedText = attributedText;
}

- (void)adjustLineSpacingWithSpacing:(CGFloat)lineSpacing range:(NSRange)range{
    if (![self respondsToSelector:@selector(setAttributedText:)] || self.text == nil) {
        return;
    }
    NSMutableAttributedString *attributedText;
    
    if (!self.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    style.alignment = self.textAlignment;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:style range:range];
    
    self.attributedText = attributedText;
}

@end
