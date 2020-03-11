//
//  UIView+SFShadow.m
//  Subway
//
//  Created by liuliu zhang on 2017/11/16.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import "UIView+SFShadow.h"

@implementation UIView (SFShadow)

- (void)addDropShadow{
    [self addDropShadowWithShadowOpacity:0.35 shadowRadius:4 cornerRadius:self.layer.cornerRadius];
}

- (void)addDropShadowWithShadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:1].CGColor;
    self.layer.masksToBounds = NO;
}

- (void)addDropShadowWithShadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius{
    CALayer *layer = self.layer;
    
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowOpacity = shadowOpacity;
    layer.shadowRadius = shadowRadius;
    layer.shadowColor = [UIColor colorWithWhite:0 alpha:1].CGColor;
    if (CGRectEqualToRect(self.bounds, CGRectZero)) {
        NSLog(@"==== The bounds of shadow view is CGRectZero, please set the correct frame before add shadow");
    }
    layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius].CGPath;
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.shouldRasterize = YES;
    layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (UIView *)dropShadowViewithFrame:(CGRect)frame shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius{
    UIView *shadowView = [[UIView alloc] initWithFrame:frame];
    shadowView.backgroundColor = [UIColor clearColor];
    [shadowView addDropShadowWithShadowOpacity:shadowOpacity shadowRadius:shadowRadius cornerRadius:cornerRadius];
    
    return shadowView;
}

@end
