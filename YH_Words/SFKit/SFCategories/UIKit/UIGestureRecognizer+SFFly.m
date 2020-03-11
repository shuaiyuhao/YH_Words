//
//  UIGestureRecognizer+SFFly.m
//  Subway
//
//  Created by liuliu zhang on 2017/11/17.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import "UIGestureRecognizer+SFFly.h"
#import <objc/runtime.h>

static const void *SFGestureRecognizerBlockKey = &SFGestureRecognizerBlockKey;

@interface UIGestureRecognizer (SFFlyPrivate)

- (void)sf_handleAction:(UIGestureRecognizer *)sender;

@end

@implementation UIGestureRecognizer (SFFly)

+ (instancetype)sf_gestureRecognizerWithHandler:(void (^)(id sender))action {
    return [[self alloc] initWithHandler:action];
}

- (instancetype)initWithHandler:(void (^)(id sender))action{
    
    self = [self initWithTarget:self action:@selector(sf_handleAction:)];
    if (!self) return nil;
    
    objc_setAssociatedObject(self, SFGestureRecognizerBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (void)sf_handleAction:(UIGestureRecognizer *)sender{
    void (^block)(id) = objc_getAssociatedObject(self, SFGestureRecognizerBlockKey);
    if (block) block(sender);
}

@end
