//
//  AppMacros.h
//  YH_Words
//
//  Created by Yuhao on 2020/3/12.
//  Copyright © 2020 Vwidea. All rights reserved.
//


#import "UIColor+SFAdd.h"
#import "UIImage+SFAdd.h"
#import "AppConstant.h"
//#import "UIColor+SFUIConfig.h"
//#import "AppDelegate+SFAdd.h"

//版本号
#define kVersion_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kVersionBuild_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#define kAppName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]

#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

#define PathTemp NSTemporaryDirectory()
#define PathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define PathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

#ifdef DEBUG
#define SFLog(message, ...) NSLog(@"%s: " message, __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#define SFLog(message, ...)
#endif

#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define kNavBar                              self.navigationController.navigationBar
#define kTabBar                              self.tabBarController.tabBar
#define kNavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define kStatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define kTabBarHeight                        self.tabBarController.tabBar.bounds.size.height
#define kScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define kScreenScale                         [UIScreen mainScreen].scale

#define kRatioWidth                          kScreenWidth/375.f
#define kRatioHeight                         kScreenHeight/667.f

//导航栏的高度
#define SFNavBarHeight 44.0
//iphoneX-SafeArea的高度
#define SFSafeAreaHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?16:0)

#define PlaceholderImage [UIImage imageNamed:@"ic_placeholder_img"]

#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0];

#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define kDevice_Is_iPhoneX ([UIScreen mainScreen].bounds.size.height == 812.0f || [UIScreen mainScreen].bounds.size.height == 896.0f)

#define kButtonSetAction(btn,function) [btn addTarget:self action:@selector(function) forControlEvents:UIControlEventTouchUpInside];

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))//弧度转角度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)//角度转弧度

#define kScaleFrom_iPhone6_Desgin(_X_) (_X_ * (kScreenWidth / 375))



