//
//  UIViewController+SFChildVC.h
//  FootBath
//
//  Created by zhang on 2017/2/20.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SFChildVC)

- (void)displayViewController:(UIViewController *)vc atContainerView:(UIView *)containerView;

- (void)hideViewController:(UIViewController *)vc;

@end
