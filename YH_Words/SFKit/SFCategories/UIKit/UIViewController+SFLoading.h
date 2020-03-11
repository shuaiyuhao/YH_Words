//
//  UIViewController+SFLoading.h
//  Barbecue
//
//  Created by zhang on 2017/6/29.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SFLoading)

- (void)startLoading;

- (void)startLoadingWithCustomView:(UIView *)customView;

- (void)stopLoading;

@end
