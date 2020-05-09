//
//  YHCancelCollectApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/8.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHCancelCollectApi.h"

@interface YHCancelCollectApi ()

@property (nonatomic,assign) NSInteger wordId;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,copy)   NSString *token;

@end

@implementation YHCancelCollectApi
- (instancetype)initWithUserId:(NSInteger)userId token:(NSString *)token wordId:(NSInteger)wordId {
    self = [super init];
    
    if (self) {
        _wordId = wordId;
        _userId = userId;
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/words/words/unCollectWords";
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
        @"wordsId":@(self.wordId),
        @"userId":@(self.userId),
        @"token":self.token
    };
}

@end
