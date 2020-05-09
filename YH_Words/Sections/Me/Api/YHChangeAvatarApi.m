//
//  YHChangeAvatarApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/9.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHChangeAvatarApi.h"

@interface YHChangeAvatarApi ()

@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *token;

@end

@implementation YHChangeAvatarApi
- (instancetype)initWithUserId:(NSInteger)userId avatar:(NSString *)avatar token:(NSString *)token {
    self = [super init];
    if (self) {
        _userId = userId;
        _avatar = avatar;
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/words/wordsUser/changeHeadSculpture";
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
        @"headSculpture":self.avatar,
        @"id":@(self.userId),
        @"token":self.token
    };
}
@end

