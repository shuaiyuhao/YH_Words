//
//  UIButton+SFBuilder.m
//  SFKit_Example
//
//  Created by liuliu zhang on 2018/6/6.
//  Copyright © 2018年 zll19911011@gmail.com. All rights reserved.
//

#import "UIButton+SFBuilder.h"

@implementation UIButton (SFBuilder)

+ (SFButtonBuilder *(^)(void))builder{
    return ^SFButtonBuilder *(){
        SFButtonBuilder *builder = [[SFButtonBuilder alloc] init];
        return builder;
    };
}

@end
