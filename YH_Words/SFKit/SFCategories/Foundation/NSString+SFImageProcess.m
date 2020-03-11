//
//  NSString+SFImageProcess.m
//  FromYuHang
//
//  Created by zhang on 2017/6/9.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "NSString+SFImageProcess.h"

@implementation NSString (SFImageProcess)

- (NSString *)imageUrlScaleToSize:(CGSize)size{
    NSURL *url = [NSURL URLWithString:self];
    return [NSString stringWithFormat:@"%@%@x-oss-process=image/resize,w_%0.f,h_%0.f",self, [url query]? @"&" : @"?", size.width,size.height];
}

@end
