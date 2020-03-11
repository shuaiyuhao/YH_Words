//
//  UIViewController+SFChildVC.m
//  FootBath
//
//  Created by zhang on 2017/2/20.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "UIViewController+SFChildVC.h"
#import "Masonry.h"

@implementation UIViewController (SFChildVC)

- (void)displayViewController:(UIViewController *)vc atContainerView:(UIView *)containerView;{
    [self addChildViewController:vc];
    if (containerView) {
        [containerView addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(containerView);
        }];
    }else{
        [self.view addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    [vc didMoveToParentViewController:self];
}

- (void)hideViewController:(UIViewController *)vc{
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

@end
