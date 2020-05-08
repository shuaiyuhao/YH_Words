//
//  UIView+SFAddLine.m
//  FootBath
//
//  Created by zhang on 2016/12/16.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "UIView+SFAddLine.h"
#import "Masonry.h"
#import "UIColor+SFAdd.h"
#import "UIView+Masonry.h"

static NSInteger const kTagLineView = 11011;

@implementation UIView (SFAddLine)

- (void)sf_addLineTop:(BOOL)hasTop bottom:(BOOL)hasBottom{
    [self sf_addLineTop:hasTop bottom:hasBottom lineColor:nil leftSpace:0 rightSpace:0];
}

- (void)sf_addLineTop:(BOOL)hasTop bottom:(BOOL)hasBottom leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace{
    [self sf_addLineTop:hasTop bottom:hasBottom lineColor:nil leftSpace:leftSpace rightSpace:rightSpace];
}

- (void)sf_addLineTop:(BOOL)hasTop bottom:(BOOL)hasBottom lineColor:(UIColor *)lineColor leftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace{
    [self sf_removeViewWithTag:kTagLineView];
    if (hasTop) {
        UIView *line = [self sf_lineWithColor:[UIColor grayColor]];
        line.tag = kTagLineView;
        [self addSubview:line];
        [self bringSubviewToFront:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(leftSpace);
            make.right.equalTo(self).offset(- rightSpace);
            make.height.equalTo(@(CGFloatFromPixel(1)));
        }];
    }
    if (hasBottom) {
        UIView *line = [self sf_lineWithColor:lineColor];
        line.tag = kTagLineView;
        [self addSubview:line];
        [self bringSubviewToFront:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(leftSpace);
            make.right.equalTo(self).offset(- rightSpace);
            make.height.equalTo(@(CGFloatFromPixel(1)));
        }];
    }
}

- (void)sf_removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}

- (UIView *)sf_line{
    return [self sf_lineWithColor:nil];
}

- (UIView *)sf_lineWithColor:(UIColor *)lineColor{
    UIView *line = [UIView new];
    line.backgroundColor = lineColor? : [UIColor colorWithHexString:@"0xE5E5E5"];
    return line;
}
@end
