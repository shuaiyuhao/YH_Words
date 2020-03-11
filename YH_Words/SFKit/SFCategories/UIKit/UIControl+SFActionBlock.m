//
//  UIControl+SFActionBlock.m
//  Subway
//
//  Created by liuliu zhang on 2017/12/2.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import "UIControl+SFActionBlock.h"
#import <objc/runtime.h>

static const void *SFActionBlockKey = &SFActionBlockKey;

@interface SFActionBlockWrapper : NSObject<NSCopying>

- (id)initWithBlock:(SFUIControlActionBlock)block forControlEvents:(UIControlEvents)controlEvents;

@property (nonatomic,assign) UIControlEvents controlEvents;
@property (nonatomic,copy) SFUIControlActionBlock block;

@end

@implementation SFActionBlockWrapper

- (id)initWithBlock:(SFUIControlActionBlock)block forControlEvents:(UIControlEvents)controlEvents{
    self = [super init];
    if (self) {
        self.block = block;
        self.controlEvents = controlEvents;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    return [[SFActionBlockWrapper alloc] initWithBlock:self.block forControlEvents:self.controlEvents];
}

- (void)sf_invokeBlock:(id)sender{
    self.block(sender);
}

@end

@implementation UIControl (SFActionBlock)

- (void)sf_addHandler:(SFUIControlActionBlock)handler forControlEvents:(UIControlEvents)controlEvents{
    NSParameterAssert(handler);
    
    NSMutableDictionary *events = objc_getAssociatedObject(self, SFActionBlockKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, SFActionBlockKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    if (!handlers) {
        handlers = [NSMutableSet set];
        events[key] = handlers;
    }
    
    SFActionBlockWrapper *target = [[SFActionBlockWrapper alloc] initWithBlock:handler forControlEvents:controlEvents];
    [handlers addObject:target];
    [self addTarget:target action:@selector(sf_invokeBlock:) forControlEvents:controlEvents];
}

- (void)sf_removeHandlerForControlEvents:(UIControlEvents)controlEvents{
    NSMutableDictionary *events = objc_getAssociatedObject(self, SFActionBlockKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, SFActionBlockKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    if (!handlers) {
        return;
    }
    [handlers enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self removeTarget:obj action:NULL forControlEvents:controlEvents];
    }];
    [events removeObjectForKey:key];
}

- (BOOL)sf_hasHandlersForControlEvents:(UIControlEvents)controlEvents{
    NSMutableDictionary *events = objc_getAssociatedObject(self, SFActionBlockKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, SFActionBlockKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];
    if (!handlers) {
        return NO;
    }
    
    return !!handlers.count;
}

@end
