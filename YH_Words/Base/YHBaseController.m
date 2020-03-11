//
//  YHBaseController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/11.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHBaseController.h"

@interface YHBaseController ()

@end

@implementation YHBaseController

#pragma mark - LifeCycle
#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
       if (@available(iOS 13.0, *)) {
           self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
       }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - status bar
#pragma mark -
- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
    if (@available(iOS 13.0, *)) {
        return UIStatusBarStyleDarkContent;
    }
    return UIStatusBarStyleDefault;//UIStatusBarStyleLightContent
}

#pragma mark - 控制屏幕旋转
#pragma mark -
- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end
