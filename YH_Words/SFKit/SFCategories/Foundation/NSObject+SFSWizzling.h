//
//  NSObject+SFSWizzling.h
//  Barbecue
//
//  Created by zhang on 2017/6/30.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (SFSWizzling)

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@end
