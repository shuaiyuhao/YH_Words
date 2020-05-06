//
//  AppDelegate+SFAdd.h
//  advertiser
//
//  Created by liuliu zhang on 2018/10/11.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (SFAdd)

- (UIViewController *)topViewController;

- (void)setRootViewController:(UIViewController*)viewController animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
 
