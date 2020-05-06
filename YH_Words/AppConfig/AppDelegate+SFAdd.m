//
//  AppDelegate+SFAdd.m
//  advertiser
//
//  Created by liuliu zhang on 2018/10/11.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "AppDelegate+SFAdd.h"

@implementation AppDelegate (SFAdd)

#pragma mark - top ViewController
#pragma mark -
- (UIViewController*)topViewController {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return [self topViewControllerWithRootViewController:window.rootViewController];
//    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

#pragma mark - util
#pragma mark -
- (void)setRootViewController:(UIViewController*)viewController animated:(BOOL)animated{
    if (self.window.rootViewController == nil) {
        animated = NO;
    }
    
    if (animated) {
        [UIView transitionWithView:self.window
                          duration:0.6
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            self.window.rootViewController = viewController;
                        }completion:nil];
        
    }else{
        self.window.rootViewController = viewController;
    }
}

@end
