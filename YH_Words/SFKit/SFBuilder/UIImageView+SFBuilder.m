//
//  UIImageView+SFBuilder.m
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import "UIImageView+SFBuilder.h"

@implementation UIImageView (SFBuilder)

+ (SFImageViewBuilder *(^)(void))builder{
    return ^SFImageViewBuilder *(){
        SFImageViewBuilder *builder = [[SFImageViewBuilder alloc] init];
        return builder;
    };
}

@end
