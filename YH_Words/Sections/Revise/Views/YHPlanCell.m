//
//  YHPlanCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/4.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHPlanCell.h"
#import <Masonry.h>
#import "UILabel+SFBuilder.h"
#import "UIColor+SFAdd.h"

@interface YHPlanCell ()

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *planLabel;

@end

@implementation YHPlanCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.planLabel];
    }
    return self;
}

+ (CGFloat)cellHeight {
    return 44.f;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark - getter and setter
#pragma mark -
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    return _iconImageView;
}

- (UILabel *)planLabel {
    if (!_planLabel) {
        _planLabel = UILabel.builder()
        .text(@"复习计划测试")
        .textColor([UIColor whiteColor])
        .textAlignment(NSTextAlignmentLeft)
        .font([UIFont systemFontOfSize:20])
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _planLabel;
}

@end
