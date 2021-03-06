//
//  YHPlanCell.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/4.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHPlanCell : UITableViewCell

- (void)configWithPlan:(NSString *)plan icon:(UIImage *)icon;

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

- (void)setIcon:(UIImage *)icon;

- (void)configWithPlan:(NSString *)plan planDone:(BOOL)planDone;

@end

NS_ASSUME_NONNULL_END
