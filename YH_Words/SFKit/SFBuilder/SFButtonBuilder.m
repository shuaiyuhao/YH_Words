//
//  SFButtonBuilder.m
//  SFKit_Example
//
//  Created by liuliu zhang on 2018/6/6.
//  Copyright © 2018年 zll19911011@gmail.com. All rights reserved.
//

#import "SFButtonBuilder.h"
#import "UIImage+SFAdd.h"

@interface SFButtonBuilder ()

@property (nonatomic,strong) UIButton *button;

@end

@implementation SFButtonBuilder

- (instancetype)init{
    self = [super init];
    if (self) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return self;
}

- (SFButtonBuilder *(^)(NSString *))title{
    return ^SFButtonBuilder *(NSString *title){
        [self.button setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

- (SFButtonBuilder *(^)(UIColor *))titleColor{
    return ^SFButtonBuilder *(UIColor *titleColor){
        [self.button setTitleColor:titleColor forState:UIControlStateNormal];
        return self;
    };
}

- (SFButtonBuilder *(^)(UIColor *))highlightedTitleColor{
    return ^SFButtonBuilder *(UIColor *highlightedTitleColor){
        [self.button setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
        [self.button setTitleColor:highlightedTitleColor forState:UIControlStateSelected];
        return self;
    };
}

- (SFButtonBuilder *(^)(UIFont *))font{
    return ^SFButtonBuilder *(UIFont *font){
        self.button.titleLabel.font = font;
        return self;
    };
}

- (SFButtonBuilder *(^)(CGFloat))fontSize{
    return ^SFButtonBuilder *(CGFloat fontSize){
        UIFont *font = [UIFont systemFontOfSize:fontSize];
        self.button.titleLabel.font = font;
        return self;
    };
}

- (SFButtonBuilder *(^)(CGFloat))cornerRadius{
    return ^SFButtonBuilder *(CGFloat cornerRadius){
        if (cornerRadius > 0) {
            self.button.layer.cornerRadius = cornerRadius;
            self.button.layer.masksToBounds = YES;
        }else{
            self.button.layer.cornerRadius = 0;
        }
        
        return self;
    };
}

- (SFButtonBuilder *(^)(UIColor *))backgroundColor{
    return ^SFButtonBuilder *(UIColor *backgroundColor){
        [self.button setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:UIControlStateNormal];
        return self;
    };
}

- (SFButtonBuilder *(^)(UIColor *))highlightedBackgroundColor{
    return ^SFButtonBuilder *(UIColor *highlightedBackgroundColor){
        [self.button setBackgroundImage:[UIImage imageWithColor:highlightedBackgroundColor] forState:UIControlStateHighlighted];
        [self.button setBackgroundImage:[UIImage imageWithColor:highlightedBackgroundColor] forState:UIControlStateSelected];
        return self;
    };
}

- (SFButtonBuilder *(^)(UIColor *))disabledBackgroundColor {
    return ^SFButtonBuilder *(UIColor *disabledBackgroundColor){
        [self.button setBackgroundImage:[UIImage imageWithColor:disabledBackgroundColor] forState:UIControlStateDisabled];
        return self;
    };
}

- (SFButtonBuilder *(^)(UIColor *))borderColor{
    return ^SFButtonBuilder *(UIColor *borderColor){
        self.button.layer.borderColor = borderColor.CGColor;
        return self;
    };
}

- (SFButtonBuilder *(^)(CGFloat))borderWidth{
    return ^SFButtonBuilder *(CGFloat borderWidth){
        self.button.layer.borderWidth = borderWidth;
        return self;
    };
}

- (SFButtonBuilder *(^)(UIImage *))image{
    return ^SFButtonBuilder *(UIImage *image){
        [self.button setImage:image forState:UIControlStateNormal];
        return self;
    };
}

- (SFButtonBuilder *(^)(UIImage *))highlightedImage{
    return ^SFButtonBuilder *(UIImage *highlightedImage){
        [self.button setImage:highlightedImage forState:UIControlStateHighlighted];
        return self;
    };
}

- (SFButtonBuilder *(^)(UIImage *))selectedImage {
    return ^SFButtonBuilder *(UIImage *selectedImage){
        [self.button setImage:selectedImage forState:UIControlStateSelected];
        return self;
    };
}

- (UIButton *(^)(void))build{
    return ^UIButton *(void) {
        return self.button;
    };
}

@end
