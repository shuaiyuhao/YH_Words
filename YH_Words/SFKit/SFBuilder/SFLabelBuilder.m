//
//  SFLabelBuilder.m
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import "SFLabelBuilder.h"
#import "UILabel+SFFly.h"

@interface SFLabelBuilder ()

@property (nonatomic,strong) UILabel *label;

@end

@implementation SFLabelBuilder

- (instancetype)init{
    self = [super init];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.opaque = YES;
        self.label.alpha = 1;
        //self.label.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (SFLabelBuilder *(^)(NSString *))text{
    return ^SFLabelBuilder *(NSString *text){
        self.label.text = text;
        return self;
    };
}

- (SFLabelBuilder *(^)(UIColor *))textColor{
    return ^SFLabelBuilder *(UIColor *textColor){
        self.label.textColor = textColor;
        return self;
    };
}

- (SFLabelBuilder *(^)(UIColor *))backgroundColor{
    return ^SFLabelBuilder *(UIColor *backgroundColor){
        self.label.backgroundColor = backgroundColor;
        return self;
    };
}

- (SFLabelBuilder *(^)(UIFont *))font{
    return ^SFLabelBuilder *(UIFont *font){
        self.label.font = font;
        return self;
    };
}

- (SFLabelBuilder *(^)(CGFloat))fontSize{
    return ^SFLabelBuilder *(CGFloat fontSize){
        self.label.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- (SFLabelBuilder *(^)(NSTextAlignment))textAlignment{
    return ^SFLabelBuilder *(NSTextAlignment textAlignment){
        self.label.textAlignment = textAlignment;
        return self;
    };
}

- (SFLabelBuilder *(^)(CGFloat))numberOfLines{
    return ^SFLabelBuilder *(CGFloat numberOfLines){
        self.label.numberOfLines = numberOfLines;
        return self;
    };
}

- (SFLabelBuilder *(^)(NSString *))boldSubstring{
    return ^SFLabelBuilder *(NSString *subString){
        NSRange range = [self.label.text rangeOfString:subString];
        [self boldRange:range];
        return self;
    };
}

- (SFLabelBuilder *(^)(NSRange))boldRange{
    return ^SFLabelBuilder *(NSRange range){
        [self boldRange:range];
        return self;
    };
}

- (SFLabelBuilder *(^)(NSString *, UIColor *))colorSubstring{
    return ^SFLabelBuilder *(NSString *subString, UIColor *newColor){
        NSRange range = [self.label.text rangeOfString:subString];
        [self colorRange:range newColor:newColor];
        return self;
    };
}

- (SFLabelBuilder *(^)(NSRange, UIColor *))colorRange{
    return ^SFLabelBuilder *(NSRange range, UIColor *newColor){
        [self colorRange:range newColor:newColor];
        return self;
    };
}

- (SFLabelBuilder *(^)(NSRange, UIColor *))strikeLineRange {
    return ^SFLabelBuilder *(NSRange range, UIColor *newColor){
        [self strikeLineRange:range newColor:newColor];
        return self;
    };
}

- (SFLabelBuilder *(^)(CGFloat))kernSpacing{
    return ^SFLabelBuilder *(CGFloat kernSpacing){
        [self.label adjustKernWithSpacing:kernSpacing];
        return self;
    };
}

- (SFLabelBuilder *(^)(CGFloat))lineSpacing{
    return ^SFLabelBuilder *(CGFloat lineSpacing){
        [self.label adjustLineSpacingWithSpacing:lineSpacing];
        return self;
    };
}

- (UILabel *(^)(void))build{
    return ^UILabel *(void){
        return self.label;
    };
}

#pragma mark - private
#pragma mark -
- (void)boldRange:(NSRange)range{
    if (![self.label respondsToSelector:@selector(setAttributedText:)] || self.label.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.label.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.label.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.label.attributedText];
    }
    [attributedText addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.label.font.pointSize]} range:range];
    
    self.label.attributedText = attributedText;
}

- (void)colorRange:(NSRange)range newColor:(UIColor *)color{
    if (![self.label respondsToSelector:@selector(setAttributedText:)] || self.label.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.label.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.label.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.label.attributedText];
    }
    
    [attributedText addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    
    self.label.attributedText = attributedText;
}

- (void)strikeLineRange:(NSRange)range newColor:(UIColor *)color{
    if (![self.label respondsToSelector:@selector(setAttributedText:)] || self.label.text == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedText;
    if (!self.label.attributedText) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:self.label.text];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.label.attributedText];
    }
    
    NSMutableDictionary *att = [NSMutableDictionary dictionaryWithDictionary:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
    if (color) {
        att[NSStrikethroughColorAttributeName] = color;
    }
    
    [attributedText addAttributes:att range:range];
    
    self.label.attributedText = attributedText;
}

@end
