//
//  YHTodayDataCollectionViewCell.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/21.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHTodayDataCollectionViewCell : YHBaseCollectionViewCell

+ (CGSize)cellSize;

- (void)configWithData:(id)data;

- (void)configWithTitle:(NSString *)title text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
