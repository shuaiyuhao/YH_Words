//
//  SFTitleTextViewCell.h
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/8/15.
//  Copyright © 2019 xiaohuodui-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFBaseTableViewCell.h"
#import "AppConstant.h"
NS_ASSUME_NONNULL_BEGIN

@interface SFTitleTextViewCell : SFBaseTableViewCell

+ (CGFloat)cellHeight;

+ (NSString *)cellIdentifier;

- (void)configWithData:(id)data;

@property (nonatomic,assign) BOOL canWrite;

@property (nonatomic,strong) SFStringActionBlock stringBlock;

- (void)setTitle:(NSString *)title textView:(NSString *)textView;

- (void)setTitle:(NSString *)title textView:(NSString *)textView placeholder:(NSString *)placeholder;

- (void)setBorderWithTitle:(NSString *)title textView:(NSString *)textView placeholder:(NSString *)placeholder;

@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,assign) NSInteger limit;

@end

NS_ASSUME_NONNULL_END
