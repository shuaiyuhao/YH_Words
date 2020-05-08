//
//  YHUploadImageApi.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/7.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHUploadImageApi.h"

@interface YHUploadImageApi ()

@property (nonatomic,strong) NSString *fileName;

@property (nonatomic,strong) NSString *imgData;

@end

@implementation YHUploadImageApi
- (instancetype)initWithName:(NSString *)fileName data:(NSString *)imgData {
    self = [super init];
    if (self) {
        _fileName = fileName;
        _imgData = imgData;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/words/wordsUser/upload";
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
        @"fileName":self.fileName,
        @"imgdata":self.imgData
    };
}
@end
