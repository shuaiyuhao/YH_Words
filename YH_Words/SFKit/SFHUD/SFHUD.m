//
//  SFHUD.m
//  FootBath
//
//  Created by zhang on 2016/12/17.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "SFHUD.h"
#import "MBProgressHUD.h"

static NSTimeInterval const kDefaultToastTime = 2.f;
static CGFloat const kMargin = 20.f;
static CGFloat const kOffsetY = 0.f;
#define kBackgroundColor [UIColor colorWithRed:56/256.f green:56/256.f blue:56/256.f alpha:1];

typedef NS_ENUM(NSInteger, SFHUDType){
    SFHUDTypeNormal = 0,
    SFHUDTypeSuccess ,
    SFHUDTypeError,
    SFHUDTypeInfo
};

@implementation SFHUD

+ (void)showToast:(NSString *)toast{
    [self showToast:toast disappearAfterSeconds:kDefaultToastTime];
}

+ (void)showToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds{
    [self showToast:toast type:SFHUDTypeNormal disappearAfterSeconds:seconds attachView:nil];
}

+ (void)showToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showToast:toast];
    });
}

+ (void)showToast:(NSString *)toast attachView:(UIView *)attachView{
    [self showToast:toast disappearAfterSeconds:kDefaultToastTime attachView:attachView];
}

+ (void)showToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView{
    [self showToast:toast type:SFHUDTypeNormal disappearAfterSeconds:seconds attachView:attachView];
}

+ (void)showToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showToast:toast attachView:attachView];
    });
}

#pragma mark - success
#pragma mark -
+ (void)showSuccessToast:(NSString *)toast{
    [self showSuccessToast:toast disappearAfterSeconds:kDefaultToastTime];
}

+ (void)showSuccessToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds{
    [self showToast:toast type:SFHUDTypeSuccess disappearAfterSeconds:seconds attachView:nil];
}

+ (void)showSuccessToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showSuccessToast:toast];
    });
}

+ (void)showSuccessToast:(NSString *)toast attachView:(UIView *)attachView{
    [self showSuccessToast:toast disappearAfterSeconds:kDefaultToastTime attachView:attachView];
}

+ (void)showSuccessToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView{
    [self showToast:toast type:SFHUDTypeSuccess disappearAfterSeconds:seconds attachView:attachView];
}

+ (void)showSuccessToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showSuccessToast:toast attachView:attachView];
    });
}

#pragma mark - error
#pragma mark -
+ (void)showErrorToast:(NSString *)toast{
    [self showErrorToast:toast disappearAfterSeconds:kDefaultToastTime];
}

+ (void)showErrorToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds{
    [self showToast:toast type:SFHUDTypeError disappearAfterSeconds:seconds attachView:nil];
}

+ (void)showErrorToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showErrorToast:toast];
    });
}

+ (void)showErrorToast:(NSString *)toast attachView:(UIView *)attachView{
    [self showErrorToast:toast disappearAfterSeconds:kDefaultToastTime attachView:attachView];
}

+ (void)showErrorToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView{
    [self showToast:toast type:SFHUDTypeError disappearAfterSeconds:seconds attachView:attachView];
}

+ (void)showErrorToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showErrorToast:toast attachView:attachView];
    });
}

#pragma mark - info
#pragma mark -
+ (void)showInfoToast:(NSString *)toast{
    [self showInfoToast:toast disappearAfterSeconds:kDefaultToastTime];
}

+ (void)showInfoToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds{
    [self showToast:toast type:SFHUDTypeInfo disappearAfterSeconds:seconds attachView:nil];
}

+ (void)showInfoToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showInfoToast:toast];
    });
}

+ (void)showInfoToast:(NSString *)toast attachView:(UIView *)attachView{
    [self showInfoToast:toast disappearAfterSeconds:kDefaultToastTime attachView:attachView];
}

+ (void)showInfoToast:(NSString *)toast disappearAfterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView{
    [self showToast:toast type:SFHUDTypeInfo disappearAfterSeconds:seconds attachView:attachView];
}

+ (void)showInfoToast:(NSString *)toast afterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showInfoToast:toast attachView:attachView];
    });
}

#pragma mark - private
#pragma mark -
+ (void)showToast:(NSString *)toast type:(SFHUDType)type disappearAfterSeconds:(NSTimeInterval)seconds attachView:(UIView *)attachView{
    MBProgressHUD *HUD;
    
    if (attachView) {
        [MBProgressHUD hideHUDForView:attachView animated:YES];
        HUD = [MBProgressHUD showHUDAddedTo:attachView animated:YES];
        
    }else {
        UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
        if (window==nil) {
            window = [[[UIApplication sharedApplication] windows] lastObject];
        }
        
        [MBProgressHUD hideHUDForView:window animated:YES];
        HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    }
    
    
    if (type == SFHUDTypeNormal) {
        HUD.mode = MBProgressHUDModeText;
    }else{
        HUD.mode = MBProgressHUDModeCustomView;
        NSString *imageName = nil;
        switch (type) {
            case SFHUDTypeSuccess:
                imageName = @"ic_tips_done";
                break;
            case SFHUDTypeError:
                imageName = @"ic_tips_error";
                break;
            case SFHUDTypeInfo:
                imageName = @"ic_tips_info";
                break;
                default:
                break;
        }
        HUD.customView = [[UIImageView alloc] initWithImage:[self sf_getImageByName:imageName]];
    }
    
    HUD.margin = kMargin;
    HUD.offset = CGPointMake(0, - kOffsetY);
    HUD.label.text = toast;
    HUD.label.textColor = [UIColor whiteColor];
    HUD.label.font = [UIFont systemFontOfSize:15];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.userInteractionEnabled = NO;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.backgroundColor = kBackgroundColor;
    HUD.animationType = MBProgressHUDAnimationZoom;
    
    [HUD hideAnimated:YES afterDelay:seconds];
}

#pragma mark - progress
#pragma mark -
+ (void)showProgressAlert{
    [self hideAlert];
    [self showProgressAlertWithText:nil];
}

+ (void)showProgressAlertWithText:(NSString *)text{
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    if (window==nil) {
        window = [[[UIApplication sharedApplication] windows] lastObject];
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.label.text =text;
    HUD.label.textColor = [UIColor whiteColor];
    HUD.label.font = [UIFont systemFontOfSize:14];
    HUD.contentColor = [UIColor whiteColor];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.backgroundColor = kBackgroundColor;
}

#pragma mark - hide
#pragma mark -
+ (void)hideAlert{
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    if (window==nil) {
        window = [[[UIApplication sharedApplication] windows] lastObject];
    }
    [MBProgressHUD hideHUDForView:window animated:YES];
}

#pragma mark - custom AlterView  ActionSheet
#pragma mark -
+ (MMSheetView *)showSheetViewWithTitle:(NSString *)title otherButtonTitles:(NSArray *)otherButtonTitles block:(MMPopupItemHandler)block{
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [MMPopupWindow sharedWindow].attachView.backgroundColor = [UIColor clearColor];
    NSMutableArray *items=[NSMutableArray array];
    for (NSString *btnTitle in otherButtonTitles) {
        [items addObject:MMItemMake(btnTitle, MMItemTypeNormal, block)];
    }
    MMSheetView *sheetView=[[MMSheetView alloc] initWithTitle:title items:items];
    
    [sheetView show];
    return sheetView;
}

+ (MMAlertView *)showAlertViewWithTitle:(NSString *)title detail:(NSString *)detail otherButtonTitles:(NSArray *)otherButtonTitles block:(MMPopupItemHandler)block{
    [MMPopupWindow sharedWindow].touchWildToHide =NO;
    [MMPopupWindow sharedWindow].attachView.backgroundColor = [UIColor clearColor];
    NSMutableArray *items=[NSMutableArray array];
    for (NSString *btnTitle in otherButtonTitles) {
        [items addObject:MMItemMake(btnTitle, MMItemTypeNormal, block)];
    }
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title detail:detail items:items];
    [alertView show];
    return alertView;
}

#pragma mark - util
#pragma mark -
+ (UIImage *)sf_getImageByName:(NSString *)name{
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath
                            stringByAppendingPathComponent:@"/SFHUD.bundle"];
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *image = [UIImage imageNamed:name
                                inBundle:resource_bundle
           compatibleWithTraitCollection:nil];
    return image;
}
@end
