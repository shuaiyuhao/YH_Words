//
//  SFBsaeTableViewCell.h
//  zhichaoyijia-client
//
//  Created by xiaohuodui-2 on 2019/11/4.
//  Copyright © 2019 xiaohuodui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "UIButton+SFBuilder.h"
#import "UILabel+SFBuilder.h"
#import "UIControl+SFActionBlock.h"
#import "UILabel+SFFly.h"
#import "UIView+SFFrame.h"
#import <UIImageView+WebCache.h>
#import "NSObject+SFHelper.h"
#import "AppMacros.h"
#import "SFTableViewDataSource.h"
#import "SFBaseTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFBaseTableViewCell : UITableViewCell<SFTableViewComponentDelegate>

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,assign) BOOL canEdit;

@property (nonatomic,assign) BOOL canSelect;

+ (CGFloat)cellHeight:(id)data;

+ (NSString *)cellIdentifier;

- (void)configWithData:(id)data;

- (void)setCellIndexPath:(NSIndexPath *)indexPath;

- (void)showLineWithTop:(BOOL)top bottom:(BOOL)bottom;

@end

NS_ASSUME_NONNULL_END
