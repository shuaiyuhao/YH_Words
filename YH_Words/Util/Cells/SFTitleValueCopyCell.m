//
//  SFTitleValueCopyCell.m
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/19.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import "SFTitleValueCopyCell.h"
#import <Masonry.h>
#import "SFHUD.h"
#import "UITextField+SFBuilder.h"
#import "UIButton+SFBuilder.h"
#import "UILabel+SFBuilder.h"
#import "UIControl+SFActionBlock.h"
#import "AppMacros.h"
#import "UIColor+SFUIConfig.h"

@interface SFTitleValueCopyCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *valuelabel;
@property (nonatomic,strong) UIButton *valueButton;

@end

@implementation SFTitleValueCopyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valuelabel];
        [self.contentView addSubview:self.valueButton];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(16);
    }];
    [self.valueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 28));
    }];
    [self.valuelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.valueButton.mas_left).offset(-16);
        make.centerY.equalTo(self.contentView);
    }];
}

+ (CGFloat)cellHeight{
    return 50.f;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)configWithData:(id)data {
    
}

- (void)setTitle:(NSString *)title value:(NSString *)value{
    self.titleLabel.text = title;
    self.valuelabel.text = value;
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

- (UILabel *)valuelabel {
    if (!_valuelabel) {
        _valuelabel = UILabel.builder()
        .text(@"婴子")
        .font([UIFont systemFontOfSize:14])
        .textColor([UIColor sf_fontBlackColor])
        .numberOfLines(1)
        .build();
    }
    return _valuelabel;
}

- (UIButton *)valueButton{
    if (!_valueButton) {
        _valueButton = UIButton.builder()
        .title(@"复制")
        .font([UIFont systemFontOfSize:14])
        .titleColor([UIColor sf_fontLightGrayColor])
        .borderColor([UIColor sf_lineColor])
        .borderWidth(1)
        .build();
        WeakSelf;
        [_valueButton sf_addHandler:^(id weakSender) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = weakSelf.valuelabel.text;
            [SFHUD showToast:@"复制到剪贴板成功"];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _valueButton;
}

@end
