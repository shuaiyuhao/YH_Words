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
        [self setBackgroundColor:[UIColor colorWithHexString:@"0x171c24"]];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.planLabel];
        
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews {
    [self.planLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
}

+ (CGFloat)cellHeight {
    return 44.f;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

- (void)configWithPlan:(NSString *)plan icon:(UIImage *)icon {
    
    self.planLabel.text = plan;
    self.iconImageView.image = icon;
}

- (void)configWithPlan:(NSString *)plan planDone:(BOOL)planDone{
    
    self.planLabel.text = plan;
    
    if (planDone) {
        self.iconImageView.image = [UIImage imageNamed:@"ic_done"];
    } else {
        self.iconImageView.image = [UIImage imageNamed:@"ic_notdone"];
    }
}

- (void)setIcon:(UIImage *)icon {
    self.iconImageView.image = icon;
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
        .textColor([UIColor grayColor])
        .textAlignment(NSTextAlignmentLeft)
        .font([UIFont systemFontOfSize:20])
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _planLabel;
}

@end
