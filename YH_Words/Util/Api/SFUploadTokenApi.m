//
//  SFUploadTokenApi.m
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/26.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "SFUploadTokenApi.h"

@implementation SFUploadTokenApi

- (NSString *)requestUrl {
    return @"/capp/v1/oss/uploadToken";
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (id)requestArgument{
    return @{
        @"type" : @(0),
    };
}

@end
