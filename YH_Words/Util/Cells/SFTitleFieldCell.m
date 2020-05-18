//
//  SFTitleFieldCell.m
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/17.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import "SFTitleFieldCell.h"
#import <Masonry.h>
#import "UITextField+SFBuilder.h"
#import "UILabel+SFBuilder.h"
#import "UITextField+SFInputLimit.h"
#import "AppMacros.h"
#import "UIColor+SFUIConfig.h"

@interface SFTitleFieldCell ()<UITextFieldDelegate>


@end

@implementation SFTitleFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueTextField];
        self.canWrite = YES;
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(16);
    }];
    [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.equalTo(self.contentView).offset(132);
        make.right.equalTo(self.contentView).offset(-16);
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

- (void)setTitileIsHidden:(BOOL)titileIsHidden {
    self.titleLabel.hidden = titileIsHidden;
    [self.valueTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-16);
    }];
}

- (void)setTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder{
    self.titleLabel.text = title;
    self.valueTextField.placeholder = placeholder;
    self.valueTextField.text = value;
}

- (void)setBorderWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder{
    self.valueTextField.layer.borderWidth = 1;
    self.valueTextField.layer.borderColor = [UIColor sf_lineColor].CGColor;
    self.valueTextField.textAlignment = NSTextAlignmentRight;
    self.valueTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.valueTextField.font = [UIFont systemFontOfSize:18];
    [self setTitle:title value:value placeholder:placeholder];
    [self.valueTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.width.equalTo(@((kScreenWidth-32)/2));
        make.right.equalTo(self.contentView).offset(-16);
    }];
}

- (void)setRightWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder{
    self.valueTextField.textAlignment = NSTextAlignmentRight;
    [self setTitle:title value:value placeholder:placeholder];
}

- (void)setRightNoBorderWithTitle:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder{
    self.valueTextField.textAlignment = NSTextAlignmentRight;
    self.valueTextField.layer.borderWidth = 0;
    [self setTitle:title value:value placeholder:placeholder];
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    self.valueTextField.secureTextEntry = secureTextEntry;
}

- (void)setLimit:(NSInteger)limit{
    _limit = limit;
    if (limit) {
        self.valueTextField.sf_maxLength = limit;
    }else{
        self.valueTextField.sf_maxLength = 0;
    }
}

- (void)setValueTextFieldLeftPadding:(double)padding {
    [self.valueTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.equalTo(self.titleLabel.mas_right).offset(padding);
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textDidChange:(UITextField *)textField {
    if(self.isBank){
//        NSString *text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//        if([text length]%4 == 0){
//            if([text length] == 19+5){
//
//            }else{
//                textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
//            }
//        }
        if(self.stringBlock)
            self.stringBlock(textField.text);
    }else{
        if(self.stringBlock)
            self.stringBlock(textField.text);
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return self.canWrite;
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

- (UITextField *)valueTextField{
    if(!_valueTextField){
        _valueTextField = UITextField.builder()
        .font([UIFont systemFontOfSize:14])
        .textColor([UIColor sf_fontHighBlackColor])
        .borderColor([UIColor sf_lineColor])
        .leftPadding(5)
//        .rightPadding(10)
        .keyboardType(UIKeyboardTypeDefault)
        .build();
        _valueTextField.delegate = self;
        [_valueTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _valueTextField;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType{
    _keyboardType = keyboardType;
    self.valueTextField.keyboardType = keyboardType;
}

@end
