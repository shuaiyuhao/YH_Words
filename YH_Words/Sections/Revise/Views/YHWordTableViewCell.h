//
//  YHWordTableViewCell.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/26.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHWordTableViewCell : UITableViewCell

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

- (void)configWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
