//
//  UIViewController+SFAdd.m
//  DateTools
//
//  Created by liuliu zhang on 2018/5/27.
//

#import "UIViewController+SFAdd.h"

@implementation UIViewController (SFAdd)

#pragma mark - top ViewController
#pragma mark -
+ (UIViewController *)topViewController{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return [self topViewControllerWithRootViewController:window.rootViewController];
    //return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
