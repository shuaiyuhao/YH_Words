//
//  NSArray+SFSwizzling.m
//  SFCategories
//  防止数组越界的尝试
//  Created by zhang on 2017/6/30.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "NSArray+SFSwizzling.h"
#import "NSObject+SFSWizzling.h"

@implementation NSArray (SFSwizzling)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod(objc_getClass("__NSArray0"), @selector(objectAtIndex:), @selector(swizzled_emptyObjectAtIndex:));
        swizzleMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(swizzled_SingleObjectAtIndex:));
        swizzleMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:), @selector(swizzled_objectAtIndex:));
        swizzleMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:), @selector(swizzled_mutableObjectAtIndex:));
        swizzleMethod(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:), @selector(swizzled_insertObject:atIndex:));
    });
}

- (id)swizzled_objectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self swizzled_objectAtIndex:index];
    }else{
        return nil;
    }
}

- (id)swizzled_mutableObjectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self swizzled_mutableObjectAtIndex:index];
    }else{
        return nil;
    }
}

- (id)swizzled_SingleObjectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self swizzled_SingleObjectAtIndex:index];
    }else{
        return nil;
    }
}

- (id)swizzled_emptyObjectAtIndex:(NSUInteger)index{
    return nil;
}

- (void)swizzled_insertObject:(id)anObject atIndex:(NSUInteger)index;{
    if (anObject) {
        [self swizzled_insertObject:anObject atIndex:index];
    }
}

@end
