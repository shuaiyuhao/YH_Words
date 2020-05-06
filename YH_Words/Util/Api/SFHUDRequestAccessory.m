//
//  SFHUDRequestAccessory.m
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/9.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "SFHUDRequestAccessory.h"
#import "SFHUD.h"
#import "UIViewController+SFLoading.h"
#import "AppMacros.h"

@implementation SFHUDRequestAccessory

- (instancetype)initWithHUDType:(SFHUDType)hudType text:(NSString * _Nullable)text {
    self = [super init];
    if (self) {
        _hudType =  hudType;
        _text = text;
    }
    return self;
}

+ (instancetype)accessoryWithHUDType:(SFHUDType)hudType {
    return [[self alloc] initWithHUDType:hudType text:nil];
}

+ (instancetype)accessoryWithHUDType:(SFHUDType)hudType text:(NSString * _Nullable)text {
    return [[self alloc] initWithHUDType:hudType text:text];
}

- (void)requestWillStart:(id)request {
    //SFLog(@"===== requestWillStart =====");
    NSArray *array = [UIApplication sharedApplication].windows;
    static UIWindow *window = nil;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj && [obj isKindOfClass:[MMPopupWindow class]]) {
            window = obj;
        }
    }];
    if (self.hudType == SFHUDTypeProgressAlert) {
        if ([self.text length]) {
            [SFHUD showProgressAlertWithText:self.text];
        }else {
            [SFHUD showProgressAlert];
        }
        
    }else {
//        [ApplicationDelegate.topViewController startLoading];
    }
}

- (void)requestWillStop:(id)request {
    //SFLog(@"===== requestWillStop =====");
    
    if (self.hudType == SFHUDTypeProgressAlert) {
        [SFHUD hideAlert];
    }else {
//        [ApplicationDelegate.topViewController stopLoading];
    }
}

- (void)requestDidStop:(id)request {
    //SFLog(@"===== requestDidStop =====");
}

@end
