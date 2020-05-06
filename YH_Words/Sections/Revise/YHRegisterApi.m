//
//  YHRegisterApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/5.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHRegisterApi.h"

@interface YHRegisterApi ()

@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *passwd;

@end

@implementation YHRegisterApi

- (instancetype)initWithPhone:(NSString *)phone username:(NSString *)userName passwd:(NSString *)passwd {
    self = [super init];
    
    if (self) {
        _phone = phone;
        _userName = userName;
        _passwd = passwd;
    }
    return self;
}

//online server:http://129.211.95.89

- (NSString *)requestUrl {
    return @"http://129.211.95.89/words/wordsUser/register";
}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeHTTP;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
        @"phone":self.phone,
        @"userName":self.userName,
        @"password":self.passwd
    };
}
@end
