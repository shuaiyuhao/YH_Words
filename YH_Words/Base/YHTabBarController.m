//
//  YHTabBarController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/31.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHTabBarController.h"
#import "YHMeController.h"
#import "YHWordController.h"
#import "YHMemoryController.h"
#import "YHReviseController.h"
#import "YHSearchWordController.h"
#import "YHLoginController.h"
#import "YHRegisterController.h"

#import "YHTabBar.h"

@interface YHTabBarController () <centerButtonDelegate>

@end

@implementation YHTabBarController


- (void)viewWillAppear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

- (void) viewDidDisappear:(BOOL)animated {
    [self.selectedViewController endAppearanceTransition];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    YHTabBar *tabbar = [YHTabBar new];
    tabbar.centerBtnDelegate = self;
    
    [self setValue:tabbar forKey:@"tabBar"];
    
    [self addCustomChildVC:[YHWordController new] title:@"单词" imageName:@"tabbar_words.png" useNav:true];
    [self addCustomChildVC:[YHReviseController new] title:@"计划"  imageName:@"tabbar_revise.png" useNav:true];
    [self addCustomChildVC:[YHRegisterController new] title:@"记忆曲线"  imageName:@"tabbar_memory.png" useNav:true];
    [self addCustomChildVC:[YHMeController new] title:@"我的" imageName:@"tabbar_me.png" useNav:true];
    

}

- (void)addCustomChildVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName useNav:(BOOL)useNav {
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    if (useNav) {
         UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self addChildViewController:nav];
    } else {
          [self addChildViewController:vc];
    }
}

#pragma mark - centerBtnDelegate
- (void)centerButtonTapped {
//    YHSearchWordController *vc = [YHSearchWordController new];
//    NSLog(@"test");
//    [self.navigationController pushViewController:vc animated:true];
    NSLog(@"test");
    [self presentViewController:[[YHSearchWordController alloc] init] animated:YES completion:nil];
}

@end
