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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [YHTabBarController new];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"0x171C24"]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    return YES;
}


@end
