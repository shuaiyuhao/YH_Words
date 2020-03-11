//
//  UITextField+SFBuilder.m
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import "UITextField+SFBuilder.h"

@implementation UITextField (SFBuilder)

+ (SFTextFieldBuilder *(^)(void))builder{
    return ^SFTextFieldBuilder *(){
        SFTextFieldBuilder *builder = [[SFTextFieldBuilder alloc] init];
        return builder;
    };
}

@end
