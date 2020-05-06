//
//  YHLoginApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/5.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHLoginApi.h"

@interface YHLoginApi ()

@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *passwd;

@end

@implementation YHLoginApi
- (instancetype)initWithPhone:(NSString *)phone passwd:(NSString *)passwd {
    self = [super init];
    
    if (self) {
        _phone = phone;
        _passwd = passwd;
        NSLog(@"%@,%@",self.phone,self.passwd);
    }
    return self;
}

- (NSString *)requestUrl {
    return @"http://129.211.95.89/words/wordsUser/login";
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
        @"phone":self.phone,
        @"password":self.passwd
    };
}
@end
