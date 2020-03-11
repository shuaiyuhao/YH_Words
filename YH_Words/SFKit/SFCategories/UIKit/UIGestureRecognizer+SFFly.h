//
//  UIGestureRecognizer+SFFly.h
//  Subway
//
//  Created by liuliu zhang on 2017/11/17.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (SFFly)

+ (instancetype)sf_gestureRecognizerWithHandler:(void (^)(id sender))action;

@end
