//
//  YHAddPlanController.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/30.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHBaseController.h"
#import "YHPlanModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol planDelegate <NSObject>

- (void)transferPlan:(YHPlanModel *)plan controller:(UIViewController *)vc;

@end

@interface YHAddPlanController : YHBaseController

@property (nonatomic,weak) id<planDelegate> planDelegate;

@end

NS_ASSUME_NONNULL_END
