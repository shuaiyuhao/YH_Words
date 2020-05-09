//
//  YHMeCollectWordsListApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/8.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHMeCollectWordsListApi.h"

@interface YHMeCollectWordsListApi ()

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,copy)   NSString *token;

@end

@implementation YHMeCollectWordsListApi
- (instancetype)initWithPage:(NSInteger)page row:(NSInteger)row userId:(NSInteger)userId token:(NSString *)token {
    self = [super init];
    
    if (self) {
        _page = page;
        _row = row;
        _userId = userId;
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/words/words/allCollectWordsList";
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
        @"page":@(self.page),
        @"rows":@(self.row),
        @"userId":@(self.userId),
        @"token":self.token
    };
}


@end
