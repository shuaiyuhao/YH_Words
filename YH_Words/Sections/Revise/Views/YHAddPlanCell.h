//
//  YHAddPlanCell.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/10.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHAddPlanCell : UITableViewCell

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

@property (nonatomic,strong) SFStringActionBlock textChangeBlock;

@end

NS_ASSUME_NONNULL_END
