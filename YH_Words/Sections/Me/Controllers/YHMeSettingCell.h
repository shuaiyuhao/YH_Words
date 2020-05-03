//
//  YHMeSettingCell.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/3.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHMeSettingCell : UITableViewCell

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *userIDLabel;

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
