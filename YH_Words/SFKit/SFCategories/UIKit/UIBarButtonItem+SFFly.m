//
//  UIBarButtonItem+SFFly.m
//  Subway
//
//  Created by liuliu zhang on 2017/11/17.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import "UIBarButtonItem+SFFly.h"
#import <objc/runtime.h>

static const void *SFBarButtonItemBlockKey = &SFBarButtonItemBlockKey;

@interface UIBarButtonItem (SFFlyPrivate)

- (void)sf_handleAction:(UIBarButtonItem *)sender;

@end

@implementation UIBarButtonItem (SFFly)

- (instancetype)sf_initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem handler:(void (^)(id sender))action{
    
    UIBarButtonItem *item = [self initWithBarButtonSystemItem:systemItem target:self action:@selector(sf_handleAction:)];
    if (!item) return nil;

    objc_setAssociatedObject(item, SFBarButtonItemBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);

    return item;
}

- (instancetype)sf_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action{
    UIBarButtonItem *item = [self initWithImage:image style:style target:self action:@selector(sf_handleAction:)];
    if (!item) return nil;
    
    objc_setAssociatedObject(item, SFBarButtonItemBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return item;
}

- (instancetype)sf_initWithImage:(UIImage *)image handler:(void (^)(id))action{
    return [self sf_initWithImage:image style:UIBarButtonItemStylePlain handler:action];
}

- (instancetype)sf_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action{
    UIBarButtonItem *item = [self initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:self action:@selector(sf_handleAction:)];
    if (!item) return nil;

    objc_setAssociatedObject(item, SFBarButtonItemBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);

    return item;
}

- (instancetype)sf_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action{
    UIBarButtonItem *item = [self initWithTitle:title style:style target:self action:@selector(sf_handleAction:)];
    if (!item) return nil;

    objc_setAssociatedObject(item, SFBarButtonItemBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);

    return item;
}

- (instancetype)sf_initWithTitle:(NSString *)title handler:(void (^)(id))action{
    return [self sf_initWithTitle:title style:UIBarButtonItemStylePlain handler:action];
}

- (void)sf_handleAction:(UIBarButtonItem *)sender{
    void (^block)(id) = objc_getAssociatedObject(self, SFBarButtonItemBlockKey);
    if (block) block(sender);
}

@end
