//
//  SFBaseApiRequest.m
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/9.
//Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "SFBaseApiRequest.h"
#import "SFErrorHandleRequestAccessory.h"
#import "AppConstant.h"
#import "YHUserManager.h"

@implementation SFBaseApiRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addAccessory:[[SFErrorHandleRequestAccessory alloc] init]];
    }
    return self;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

//- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
//    return @{
//             @"Authorization" : [SFUserManager sharedManager].token?:@"",
//             };
//
//}

- (id)fetchDataWithReformer:(id<SFReformerProtocol>)reformer {
    if (reformer == nil) {
        if ([self.responseObject isKindOfClass:[NSDictionary class]] && self.responseObject[@"data"]) {
            return self.responseObject[@"data"];
        }
        return self.responseObject;
        
    }else {
        return [reformer reformDataWithApiRequest:self];
    }
}

- (id)fetchRawData {
    return self.responseObject;
}

- (NSString *)errorMsg {
    id result = nil;
    NSInteger httpStatusCode = self.responseStatusCode;
    result = self.responseObject;
    
    if (httpStatusCode >= 400) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSString *msg = result[@"msg"];
            return msg;
        }
    }
    
    return nil;
}

- (NSInteger)errorCode {
    id result = nil;
    NSInteger httpStatusCode = self.responseStatusCode;
    result = self.responseObject;
    
    if (httpStatusCode >= 200) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSNumber *code = result[@"code"];
            return [code integerValue];
        }
    }
    
    return -1;
}

- (BOOL)success {
    id result = nil;
    result = self.responseObject;
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSNumber *code = result[@"code"];
        if (![code boolValue]) {
            return YES;
        } else{
            return NO;
        }
    }
    return NO;
}

@end
