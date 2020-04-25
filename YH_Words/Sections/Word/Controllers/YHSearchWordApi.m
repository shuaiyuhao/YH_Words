//
//  YHSearchWordApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/24.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHSearchWordApi.h"
#import "YHMD5Tool.h"

@interface YHSearchWordApi ()

@property (nonatomic,strong) NSString *word;
@property (nonatomic,strong) NSString *appId;
@property (nonatomic,strong) NSString *salt;
@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *signMD5;

@end

@implementation YHSearchWordApi
- (instancetype)initWithWord:(NSString *)word {
    self = [super init];
    if (self) {
        _word = word;
        
        _appId = @"20200424000429061";
        _salt = @"1435660288";
        _key = @"f55xCuoFu8guV0LF6w_i";
        _sign = [NSString stringWithFormat:@"%@%@%@%@", _appId,_word,_salt,_key];
        
        self.signMD5 = [YHMD5Tool MD5ForLower32Bate:_sign];
        NSLog(@"%@", self.signMD5);
    }
    return self;
}

- (NSString *)requestUrl {
    return @"https://fanyi-api.baidu.com/api/trans/vip/translate";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

//- (YTKRequestSerializerType)requestSerializerType {
//    return YTKRequestSerializerTypeJSON;
//}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

- (id)requestArgument {
    return @{
        @"q":self.word,
        @"from":@"en",
        @"to":@"zh",
        @"appid":self.appId,
        @"salt":self.salt,
        @"sign":self.signMD5
    };
}
@end
