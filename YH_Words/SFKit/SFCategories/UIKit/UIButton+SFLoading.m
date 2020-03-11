//
//  UIButton+SFLoading.m
//  Subway
//
//  Created by liuliu zhang on 2017/12/2.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import "UIButton+SFLoading.h"
#import <objc/runtime.h>

static const void *SFIndicatorViewKey = &SFIndicatorViewKey;
static const void *SFButtonTextKey = &SFButtonTextKey;

@implementation UIButton (SFLoading)

- (void)sf_showIndicator{
    [self sf_showIndicatorWithText:@""];
}

- (void)sf_showIndicatorWithText:(NSString *)text{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    indicator.hidesWhenStopped = YES;
    indicator.color = [self titleColorForState:UIControlStateNormal];
    [indicator startAnimating];
    
    NSString *buttonText = self.titleLabel.text;
    objc_setAssociatedObject(self, SFIndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, SFButtonTextKey, buttonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTitle:text forState:UIControlStateNormal];
    self.enabled = NO;
    [self addSubview:indicator];
}

- (void)sf_hideIndicator{
    NSString *buttonText = objc_getAssociatedObject(self, SFButtonTextKey);
    UIActivityIndicatorView *indicator = objc_getAssociatedObject(self, SFIndicatorViewKey);
    
    if (indicator) {
        [indicator removeFromSuperview];
    }
    [self setTitle:buttonText forState:UIControlStateNormal];
    self.enabled = YES;
}

@end
