//
//  YHTabBar.h
//  YH_Words
//
//  Created by Yuhao on 2020/3/27.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstant.h"

NS_ASSUME_NONNULL_BEGIN

@protocol centerButtonDelegate <NSObject>

- (void)centerButtonTapped;

@end

@interface YHTabBar : UITabBar

//@property (nonatomic,strong) SFVoidActionBlock centerButtonBlock;
@property (nonatomic,weak) id<centerButtonDelegate> centerBtnDelegate;

@end

NS_ASSUME_NONNULL_END
