//
//  YHTodayWordsListApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/8.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHTodayWordsListApi.h"

@interface YHTodayWordsListApi ()

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) NSInteger userId;

@property (nonatomic,copy)   NSString *token;

@end

@implementation YHTodayWordsListApi
- (instancetype)initWithPage:(NSInteger)page row:(NSInteger)row type:(NSInteger)type userId:(NSInteger)userId token:(NSString *)token {
    self = [super init];
    
    if (self) {
        _page = page;
        _row = row;
        _type = type;
        _userId = userId;
        _token = token;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/words/words/todayWordsList";
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
        @"type":@(self.type),
        @"userId":@(self.userId),
        @"token":self.token
    };
}

@end
