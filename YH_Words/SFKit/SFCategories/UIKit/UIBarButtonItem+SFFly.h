//
//  UIBarButtonItem+SFFly.h
//  Subway
//
//  Created by liuliu zhang on 2017/11/17.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SFFly)

- (instancetype)sf_initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem handler:(void (^)(id sender))action;

- (instancetype)sf_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action;

- (instancetype)sf_initWithImage:(UIImage *)image handler:(void (^)(id sender))action;

- (instancetype)sf_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action;

- (instancetype)sf_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(void (^)(id sender))action;

- (instancetype)sf_initWithTitle:(NSString *)title handler:(void (^)(id sender))action;

@end
