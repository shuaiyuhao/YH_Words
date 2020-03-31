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

#import "YHTabBar.h"

@interface YHTabBarController ()

@end

@implementation YHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setValue:[YHTabBar new] forKey:@"tabBar"];
   
    [self addCustomChildVC:[YHWordController new] title:@"单词" imageName:@"tabbar_words.png"];
    [self addCustomChildVC:[YHReviseController new] title:@"计划"  imageName:@"tabbar_revise.png"];
    [self addCustomChildVC:[YHMemoryController new] title:@"记忆曲线"  imageName:@"tabbar_memory.png"];
    [self addCustomChildVC:[YHMeController new] title:@"我的"  imageName:@"tabbar_me.png"];
    
}

- (void)viewWillAppear:(BOOL)animated {
   
}

- (void)addCustomChildVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName {
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:vc];
    
}


@end
