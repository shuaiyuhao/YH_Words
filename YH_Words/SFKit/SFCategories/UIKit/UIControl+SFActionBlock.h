//
//  UIControl+SFActionBlock.h
//  Subway
//
//  Created by liuliu zhang on 2017/12/2.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SFUIControlActionBlock)(id weakSender);

@interface UIControl (SFActionBlock)

- (void)sf_addHandler:(SFUIControlActionBlock)handler forControlEvents:(UIControlEvents) controlEvents;

- (void)sf_removeHandlerForControlEvents:(UIControlEvents)controlEvents;

- (BOOL)sf_hasHandlersForControlEvents:(UIControlEvents)controlEvents;

@end
