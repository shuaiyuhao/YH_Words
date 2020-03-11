//
//  SFHUD.h
//  FootBath
//
//  Created by zhang on 2016/12/17.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MMPopupItem.h"
#import "MMAlertView.h"
#import "MMSheetView.h"

@interface SFHUD : NSObject

+ (void)showToast:(NSString *)toast;
+ (void)showToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds;
+ (void)showToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds;
+ (void)showToast:(NSString *)toast attachView:(UIView *)attachView;
+ (void)showToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView;
+ (void)showToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView;

+ (void)showSuccessToast:(NSString *)toast;
+ (void)showSuccessToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds;
+ (void)showSuccessToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds;
+ (void)showSuccessToast:(NSString *)toast attachView:(UIView *)attachView;
+ (void)showSuccessToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView;
+ (void)showSuccessToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView;


+ (void)showErrorToast:(NSString *)toast;
+ (void)showErrorToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds;
+ (void)showErrorToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds;
+ (void)showErrorToast:(NSString *)toast attachView:(UIView *)attachView;
+ (void)showErrorToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView;
+ (void)showErrorToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView;

+ (void)showInfoToast:(NSString *)toast;
+ (void)showInfoToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds;
+ (void)showInfoToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds;
+ (void)showInfoToast:(NSString *)toast attachView:(UIView *)attachView;
+ (void)showInfoToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView;
+ (void)showInfoToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView;

+ (void)showProgressAlert;
+ (void)showProgressAlertWithText:(NSString *)text;

+ (void)hideAlert;

// custom AlertView ActionSheetView

+ (MMSheetView *)showSheetViewWithTitle:(NSString *)title otherButtonTitles:( NSArray *)otherButtonTitles block:(MMPopupItemHandler)block;

+ (MMAlertView *)showAlertViewWithTitle:(NSString *)title detail:(NSString *)detail otherButtonTitles:(NSArray *)otherButtonTitles block:(MMPopupItemHandler)block;

@end
