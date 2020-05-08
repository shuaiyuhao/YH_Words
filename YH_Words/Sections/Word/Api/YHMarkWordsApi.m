//
//  YHMarkWordsApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/7.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHMarkWordsApi.h"

 // 类型：1：浏览 2：模糊 3：记忆 4：收藏
@interface YHMarkWordsApi ()

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,assign) NSInteger wordsId;
@property (nonatomic,copy)   NSString *token;

@end

@implementation YHMarkWordsApi
- (instancetype)initWithType:(NSInteger)type token:(NSString *)token userId:(NSInteger)userId wordId:(NSInteger)wordId {
    self = [super init];
    if (self) {
        _type = type;
        _userId = userId;
        _wordsId = wordId;
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/words/words/markWords";
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
        @"userId":@(self.userId),
        @"wordsId":@(self.wordsId),
        @"token":self.token
    };
}
@end
