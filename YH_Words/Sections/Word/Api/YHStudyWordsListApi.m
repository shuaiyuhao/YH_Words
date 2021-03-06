//
//  YHStudyWordsListApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/6.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHStudyWordsListApi.h"

@interface YHStudyWordsListApi ()

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,copy)   NSString *token;
@property (nonatomic,assign) NSInteger userId;
@end

@implementation YHStudyWordsListApi
- (instancetype)initWithPage:(NSInteger)page row:(NSInteger)row token:(NSString *)token userId:(NSInteger)userId {
    self = [super init];
    
    if (self) {
        _page = page;
        _row = row;
        _token = token;
        _userId = userId;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/words/words/wordsList";
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
        @"token":self.token,
        @"userId":@(self.userId)
    };
}
@end
