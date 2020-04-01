//
//  YHTitleFieldView.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/12.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHTitleFieldView.h"
#import "UITextField+SFBuilder.h"
#import "UIView+SFAddLine.h"

@interface YHTitleFieldView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextField *valueTextField;
@property (nonatomic,strong) UIButton *showButton;

@end

@implementation YHTitleFieldView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self sf_addLineTop:NO bottom:YES lineColor:[UIColor grayColor] leftSpace:0 rightSpace:0];
        [self addSubview:self.titleLabel];
        [self addSubview:self.valueTextField];
        [self addSubview:self.showButton];
        
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.equalTo(@20);
           make.left.equalTo(self).offset(11);
           make.centerY.equalTo(self);
       }];
       
       [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.equalTo(@20);
           make.width.equalTo(@230);
           make.left.equalTo(self.titleLabel.mas_right).offset(20);
           make.centerY.equalTo(self);
       }];
       
       [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
           make.size.mas_equalTo(CGSizeMake(20, 20));
           make.centerY.equalTo(self);
           make.right.equalTo(self).offset(0);
       }];
}

- (void)configWithTitle:(NSString *)title palceHolder:(NSString *)placeHolder showImage:(UIImage *)image keyBoardType:(UIKeyboardType)keyBoardType secureTextEntry:(BOOL)secureTextEntry{
    self.titleLabel.text = title;
    self.valueTextField.placeholder = placeHolder;
    if (image) {
        self.showButton.hidden = NO;
        [self.showButton setImage:image forState:UIControlStateNormal];
    }
    self.valueTextField.keyboardType = keyBoardType;
    self.valueTextField.secureTextEntry = secureTextEntry;;
}

- (void)configWithTitle:(NSString *)title placeholder:(NSString *)placeholder customView:(id)customView keyBoardType:(UIKeyboardType)keyBoardType secureTextEntry:(BOOL)secureTextEntry {
    self.titleLabel.text = title;
    self.valueTextField.placeholder = placeholder;
    self.valueTextField.keyboardType = keyBoardType;
    self.valueTextField.secureTextEntry = secureTextEntry;
    
    UIView *view = customView;
    [self addSubview:view];
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(view.frame.size);
        make.right.equalTo(self).offset(0);
        make.centerY.equalTo(self);
    }];
   
    [self.valueTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-1);
        make.left.equalTo(self.titleLabel.mas_right).offset(20);
        make.width.equalTo(@160);
    }];
}

- (void)textDidChange:(UITextField *)sender {
    if (self.textChangeBlock) {
        self.textChangeBlock(sender.text);
    }
}

- (void)setShowImage:(UIImage *)showImage secureTextEntry:(BOOL)secureTextEntry {
    [self.showButton setImage:showImage forState:UIControlStateNormal];
    self.valueTextField.secureTextEntry = secureTextEntry;
    self.showButton.tag = !self.showButton.tag;
}

#pragma mark -- getter and setter
#pragma mark --
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.builder()
        .text(@"")
        .textColor([UIColor grayColor])
        .font([UIFont systemFontOfSize:14])
        .backgroundColor([UIColor clearColor])
        .textAlignment(NSTextAlignmentLeft)
        .build();
    }
    return _titleLabel;
}

- (UITextField *)valueTextField {
    if (!_valueTextField) {
        _valueTextField = UITextField.builder()
        .placeholder(@"")
        .text(@"")
        .font([UIFont systemFontOfSize:14])
        .backgroundColor([UIColor clearColor])
        .build();
        _valueTextField.textAlignment = NSTextAlignmentLeft;
        
        _valueTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.valueTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _valueTextField;
}

- (UIButton *)showButton {
    if (!_showButton) {
        _showButton = UIButton.builder()
        .build();
        _showButton.hidden = YES;
        _showButton.tag = 0;
        WeakSelf;
        [self.showButton sf_addHandler:^(id weakSender) {
            if (weakSelf.buttonActionBlock) {
                weakSelf.buttonActionBlock(self.showButton.tag);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _showButton;
}
@end
