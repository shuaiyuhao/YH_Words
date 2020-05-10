//
//  YHMemoryLineApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/7.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHRememberLineApi.h"

@interface YHRememberLineApi ()

@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,copy)   NSString  *token;

@end

@implementation YHRememberLineApi
- (instancetype)initWithUserId:(NSInteger)userId token:(NSString *)token type:(NSInteger)type {
    self = [super init];
    if (self) {
        _userId = userId;
        _type = type;
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/words/words/weekRememberList";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
        @"type":@(self.type),
        @"token":self.token,
        @"userId":@(self.userId)
    };
}
@end
