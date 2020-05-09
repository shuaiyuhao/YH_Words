//
//  YHCollectWordApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/8.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHCollectWordApi.h"

@interface YHCollectWordApi ()

@property (nonatomic,copy) NSString *token;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,assign) NSInteger wordId;

@end


@implementation YHCollectWordApi
- (instancetype)initWithToken:(NSString *)token userId:(NSInteger)userId wordId:(NSInteger)wordId {
    self = [super init];
    
    if (self) {
        _token = token;
        _userId = userId;
        _wordId = wordId;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/words/words/collectWords";
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
        @"token":self.token,
        @"userId":@(self.userId),
        @"wordsId":@(self.wordId)
    };
}

@end
