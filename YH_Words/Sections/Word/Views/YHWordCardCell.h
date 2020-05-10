//
//  YHWordCardCell.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/22.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "QiCardView.h"

NS_ASSUME_NONNULL_BEGIN

@class YHWordCardCell;

@protocol YHWordCardCellDelegate <NSObject>

@optional

/// 单词发声
/// @param soundText  soundText
/// @param text text
- (void)cardViewCell:(YHWordCardCell *)cell soundText:(NSString *)text;


@end

@interface YHWordCardCell : QiCardViewCell

@property (nonatomic,weak) id <YHWordCardCellDelegate>delegate;

- (void)configWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
