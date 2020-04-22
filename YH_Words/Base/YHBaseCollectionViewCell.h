//
//  YHBaseCollectionViewCell.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/21.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "UIButton+SFBuilder.h"
#import "UILabel+SFBuilder.h"
#import "UIButton+SFEdgeInsets.h"
#import "UIColor+SFAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHBaseCollectionViewCell : UICollectionViewCell

+ (NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
