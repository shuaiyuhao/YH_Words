//
//  AppDelegate.m
//  YH_Words
//
//  Created by Yuhao on 2020/1/12.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+SFAdd.h"
#import "YHTabBarController.h"
#import "YHLoginController.h"
#import <iflyMSC/iflyMSC.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.window makeKeyAndVisible];
    
    YHLoginController *vc = [YHLoginController new];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"0x171C24"]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", @"5eb7a7df"];
    [IFlySpeechUtility createUtility:initString];
    
    return YES;
}


@end
