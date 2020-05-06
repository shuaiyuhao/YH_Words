//
//  SFTokenRequestAccessory.m
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/9.
//Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "SFErrorHandleRequestAccessory.h"
#import <AFNetworkReachabilityManager.h>
#import "SFHUD.h"
#import "AppMacros.h"
#import "NSObject+SFHelper.h"

@implementation SFErrorHandleRequestAccessory

- (void)requestWillStart:(id)request {
    //SFLog(@"===== requestWillStart =====");
}

- (void)requestWillStop:(id)request {
    //SFLog(@"===== requestWillStop =====");
}

- (void)requestDidStop:(id)request {
    //SFLog(@"===== requestDidStop =====");
    YTKBaseRequest *specificRequest = (YTKBaseRequest *)request;
    NSInteger httpStatusCode = specificRequest.responseStatusCode;
    
    void(^showErrorMsg)(void) = ^() {
        id result = specificRequest.responseObject;
        NSString *msg;
        BOOL success = YES;
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (result[@"success"]) {
                success = [result[@"success"] boolValue];
            }
            msg = result[@"message"];
        }
        
        if (!success && [msg length]) {
            [SFHUD showToast:msg attachView:nil];
        }
        if (!success) {        
            SFLog(@"==== error = %@", result);
        }
    };
    
    if (httpStatusCode == 401) {
        //token error
        [[NSNotificationCenter defaultCenter] postNotificationName:kTokenExpiredNotification object:nil];
        
    }else if (httpStatusCode >= 200) {
        
        showErrorMsg();
        
    }else if (httpStatusCode == 0) {
        
        if (![AFNetworkReachabilityManager sharedManager].isReachable) {
            SFLog(@"==== className = %@", NSStringFromClass([specificRequest class]));
            NSString * msg = @"网络好像有点问题哦～";
            [SFHUD showToast:msg afterSeconds:0.3];
        }
        
    }
}

@end
