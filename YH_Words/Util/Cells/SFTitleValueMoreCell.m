//
//  SFTitleValueMoreCell.m
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/8/22.
//  Copyright © 2019 xiaohuodui-2. All rights reserved.
//

#import "SFTitleValueMoreCell.h"
#import <Masonry.h>
#import "UILabel+SFFly.h"
#import "UILabel+SFBuilder.h"
#import "AppMacros.h"
#import "UIColor+SFUIConfig.h"

@interface SFTitleValueMoreCell ()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *valueLabel;

@end

@implementation SFTitleValueMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueLabel];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(16);
        make.width.equalTo(@80);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.right.bottom.equalTo(self.contentView).offset(-16);
        make.left.equalTo(self.titleLabel.mas_right).offset(16);
    }];
    
}

+ (CGFloat)cellHeight{
    return 120.f;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)configWithData:(id)data {
    
}

- (void)setTitle:(NSString *)title value:(NSString *)value{
    self.titleLabel.text = title;
    self.valueLabel.text = value;
    [self.valueLabel adjustLineSpacingWithSpacing:4];
    self.valueLabel.hidden = NO;
    if(!value.length){
        self.valueLabel.hidden = YES;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(16);
            make.bottom.equalTo(self.contentView).offset(-16);
        }];
    }
}

- (void)setTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder{
    if(value.length){
        self.valueLabel.textColor = [UIColor sf_fontBlackColor];
        [self setTitle:title value:value];
        return;
    }
    self.valueLabel.textColor = [UIColor sf_fontHighGrayColor];
    [self setTitle:title value:placeholder];
}

#pragma mark - getter and setter
#pragma mark -
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.builder()
        .text(@"婴子")
        .font([UIFont systemFontOfSize:14])
        .textColor([UIColor sf_fontLightBlackColor])
        .numberOfLines(1)
        .build();
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = UILabel.builder()
        .text(@"婴子")
        .font([UIFont systemFontOfSize:14])
        .textColor([UIColor sf_fontBlackColor])
        .numberOfLines(0)
        .textAlignment(NSTextAlignmentRight)
        .build();
    }
    return _valueLabel;
}
@end
