//
//  NSObject+SFSWizzling.m
//  Barbecue
//
//  Created by zhang on 2017/6/30.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "NSObject+SFSWizzling.h"

@implementation NSObject (SFSWizzling)

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
