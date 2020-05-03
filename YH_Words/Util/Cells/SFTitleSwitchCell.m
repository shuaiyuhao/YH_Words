//
//  SFTitleSwitchCell.m
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/19.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import "SFTitleSwitchCell.h"
#import <Masonry.h>
#import "UITextField+SFBuilder.h"
#import "UILabel+SFBuilder.h"
#import "AppMacros.h"
#import "UIColor+SFUIConfig.h"

@interface SFTitleSwitchCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UISwitch *valueSwitch;

@property (nonatomic,strong) UILabel *valueLabel;

@end

@implementation SFTitleSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueSwitch];
        [self.contentView addSubview:self.valueLabel];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(10);
    }];
    [self.valueSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
    }];
}

+ (CGFloat)cellHeight{
    return 50.f;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)configWithData:(id)data {
    if(data && [data isKindOfClass:[SFBaseTableViewModel class]]){
        SFBaseTableViewModel *model = data;
        self.indexBlock = model.block;
        if (model.data && [model.data isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = model.data;
            BOOL isOn = [dic[@"isOn"] boolValue];
            [self setTitle:dic[@"title"]?:@"" status:isOn];
            self.titleLabel.textColor = [UIColor sf_fontBlackColor];
            
            NSString *value = dic[@"value"];
            if (value && value.length) {
                self.valueLabel.text = value;
                self.valueLabel.hidden = NO;
            }else{
                self.valueLabel.hidden = YES;
            }
        }
    }
}

- (void)setTitle:(NSString *)title status:(BOOL)status{
    self.titleLabel.text = title;
    self.valueSwitch.on = status;
}

- (void)didChange:(UISwitch *)sender{
    if(self.indexBlock){
        self.indexBlock(sender.isOn);
    }
}

- (void)configWithOn:(BOOL)isOn{
    self.valueSwitch.on = isOn;
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

- (UISwitch *)valueSwitch{
    if(!_valueSwitch){
        _valueSwitch = [[UISwitch alloc]init];
        [_valueSwitch addTarget:self action:@selector(didChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _valueSwitch;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = UILabel.builder()
        .text(@"")
        .font([UIFont systemFontOfSize:12])
        .textColor([UIColor sf_appRedColor])
        .backgroundColor([[UIColor sf_appRedColor] colorWithAlphaComponent:.3])
        .numberOfLines(1)
        .build();
        _valueLabel.hidden = YES;
    }
    return _valueLabel;
}

@end
