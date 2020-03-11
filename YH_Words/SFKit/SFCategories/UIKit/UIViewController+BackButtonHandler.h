//
//  UIViewController+BackButtonHandler.h
//  JianLianTimerForStudent
//
//  Created by zhang on 16/7/3.
//  Copyright © 2016年 zhangliuliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>

@optional
- (BOOL)navigationShouldPopOnBackButton;

@end


/**
 监听ViewController的返回键
 */
@interface UIViewController (BackButtonHandler)<BackButtonHandlerProtocol>

@end
