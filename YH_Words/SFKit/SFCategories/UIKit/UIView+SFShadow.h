//
//  UIView+SFShadow.h
//  Subway
//
//  Created by liuliu zhang on 2017/11/16.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SFShadow)

- (void)addDropShadow;

- (void)addDropShadowWithShadowOpacity:(CGFloat)shadowOpacity
                          shadowRadius:(CGFloat)shadowRadius;


/**
 给一个view添加shadow 用UIBezierPath 创建一个shadow path；
 需要注意：如果view maskToBounds = YES,则不起作用
 
 @param shadowOpacity shadowOpacity
 @param shadowRadius shadowRadius
 @param cornerRadius cornerRadius
 */
- (void)addDropShadowWithShadowOpacity:(CGFloat)shadowOpacity
                          shadowRadius:(CGFloat)shadowRadius
                          cornerRadius:(CGFloat)cornerRadius;


/**
 创建一个单独的添加shadow的view
 
 @param frame frame 必传，否则不起作用
 @param shadowOpacity shadowOpacity
 @param shadowRadius shadowRadius
 @param cornerRadius cornerRadius
 @return shadow view
 */
- (UIView *)dropShadowViewithFrame:(CGRect)frame
                     shadowOpacity:(CGFloat)shadowOpacity
                      shadowRadius:(CGFloat)shadowRadius
                      cornerRadius:(CGFloat)cornerRadius;

@end
