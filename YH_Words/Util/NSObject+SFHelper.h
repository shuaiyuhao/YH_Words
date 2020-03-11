//
//  NSObject+SFHelper.h
//  zhichaoyijia-client
//
//  Created by xiaohuodui-2 on 2019/10/28.
//  Copyright © 2019 xiaohuodui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JXCategoryTitleView.h>
#import <JXCategoryView.h>
#import "YHBaseController.h"
#import <UIKit/UIKit.h>
#import "AppMacros.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SFGradientType) {
    SFGradientTypeTopToBottom = 0,//从上到下
    SFGradientTypeLeftToRight = 1,//从左到右
    SFGradientTypeUpleftToLowright = 2,//左上到右下
    SFGradientTypeUprightToLowleft = 3,//右上到左下
};

@interface NSObject (SFHelper)

- (void)toBorderColor:(UIColor *)color toBorderWidth:(CGFloat)borderWidth withUIView:(UIView *)view;

- (void)toCornradius:(CGFloat)cornerRadius with:(UIView *)view;

- (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(SFGradientType)gradientType imgSize:(CGSize)imgSize;

- (UIImage *)imageRedToWhiteWithRect:(CGRect)rect allSize:(CGSize)allSize;

- (UIWindow *)lastWindowOrMMPopupWindow;

- (void)configAction:(UIView *)view withActionBlock:(SFObjectActionBlock)block;

- (CGSize)getStringSizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size;

//字符串转model @"[\"at, to or from a great distance in space or time\",\"very much, or to a great degree\"]" -> []
- (id)sf_stringToJSONObject:(NSString *)jsonString;

//图片模糊效果
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

- (UIButton *)buttonWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
