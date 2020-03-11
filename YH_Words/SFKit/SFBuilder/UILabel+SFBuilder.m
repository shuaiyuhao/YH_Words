//
//  UILabel+SFBuilder.m
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import "UILabel+SFBuilder.h"

@implementation UILabel (SFBuilder)

+ (SFLabelBuilder *(^)(void))builder{
    return ^SFLabelBuilder *(){
        SFLabelBuilder *builder = [[SFLabelBuilder alloc] init];
        return builder;
    };
}

@end
