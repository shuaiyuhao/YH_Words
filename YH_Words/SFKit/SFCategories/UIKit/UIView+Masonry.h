//
//  UIView+Masonry.h
//  JianLianTimerForStudent
//
//  Created by zhang on 16/6/16.
//  Copyright © 2016年 zhangliuliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Masonry)

- (void) distributeSpacingHorizontallyWith:(NSArray*)views;

- (void) distributeSpacingVerticallyWith:(NSArray*)views;

@end

static inline CGFloat CGFloatFromPixel(CGFloat value) {
    return value / [UIScreen mainScreen].scale ;
}
