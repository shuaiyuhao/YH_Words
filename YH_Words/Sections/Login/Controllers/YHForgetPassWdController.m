//
//  YHForgetPassWdController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/14.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHForgetPassWdController.h"
#import "YHTitleFieldView.h"
#import <JKCountDownButton.h>


@interface YHForgetPassWdController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) YHTitleFieldView *phoneView;
@property (nonatomic,strong) YHTitleFieldView *codeView;

@property (nonatomic,strong) YHTitleFieldView *passwordView;
@property (nonatomic,strong) YHTitleFieldView *confirmPasswordView;
@property (nonatomic,strong) JKCountDownButton *codeButton;
@property (nonatomic,strong) UIButton *confirmButton;

@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *confirmPassword;

@end

@implementation YHForgetPassWdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"忘记密码";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.view.backgroundColor = [UIColor colorWithHexString:@"0x171C25"];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.passwordView];
    [self.view addSubview:self.confirmPasswordView];
    [self.view addSubview:self.confirmButton];
    
    [self layoutPageViews];
}

- (void)layoutPageViews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@24);
        make.top.equalTo(self.view).offset(12);
        make.left.equalTo(self.view).offset(24);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 44));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(80);
        make.centerX.equalTo(self.view);
    }];
    
        [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 44));
            make.top.equalTo(self.phoneView.mas_bottom).offset(8);
            make.centerX.equalTo(self.view);
        }];
    
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 44));
        make.top.equalTo(self.codeView.mas_bottom).offset(8);
        make.centerX.equalTo(self.view);
    }];
    
    [self.confirmPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 44));
        make.top.equalTo(self.passwordView.mas_bottom).offset(8);
        make.centerX.equalTo(self.view);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 44));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.confirmPasswordView.mas_bottom).offset(140);
    }];
    
}


#pragma mark - getter and setter
#pragma mark -
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.builder()
        .text(@"重设密码")
        .textColor([UIColor colorWithHexString:@"0xD66563"])
        .font([UIFont systemFontOfSize:24 weight:UIFontWeightBold])
        .textAlignment(NSTextAlignmentLeft)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _titleLabel;
}

- (YHTitleFieldView *)phoneView {
    if (!_phoneView) {
        _phoneView = [YHTitleFieldView new];
        [_phoneView configWithTitle:@"手机号" palceHolder:@"请输入手机号" showImage:nil keyBoardType:UIKeyboardTypeDefault secureTextEntry:NO];
         _phoneView.backgroundColor = [UIColor colorWithHexString:@"0x171C25"];
        WeakSelf;
        [_phoneView setTextChangeBlock:^(NSString *index) {
            weakSelf.phone = index;
        }];
    }
    return _phoneView;
}

- (YHTitleFieldView *)codeView {
    if (!_codeView) {
        _codeView = [YHTitleFieldView new];
        [_codeView configWithTitle:@"验证码" placeholder:@"请输入验证码" customView:self.codeButton keyBoardType:UIKeyboardTypeNumberPad secureTextEntry:NO];
        
        _codeView.backgroundColor = [UIColor colorWithHexString:@"0x171C25"];
        WeakSelf;
        [_codeView setTextChangeBlock:^(NSString *index) {
            weakSelf.code = index;
        }];
    }
    return _codeView;
}

- (JKCountDownButton *)codeButton {
    if (!_codeButton) {
        _codeButton = [[JKCountDownButton alloc] initWithFrame:CGRectMake(0, 0, 98, 28)];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_codeButton setTitleColor:[UIColor colorWithHexString:@"0xD66563"] forState:UIControlStateNormal];
        [_codeButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [_codeButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0x171C25"]] forState:UIControlStateNormal];
        [_codeButton setBackgroundImage:[self gradientColorImageFromColors:@[[UIColor colorWithHexString:@"0x48c6ef"],[UIColor colorWithHexString:@"0xD66563"]] gradientType:SFGradientTypeLeftToRight imgSize:CGSizeMake(98, 28)] forState:UIControlStateDisabled];
        [self toCornradius:14 with:_codeButton];
        [self toBorderColor:[UIColor colorWithHexString:@"0xD66563"] toBorderWidth:1 withUIView:_codeButton];
        
        WeakSelf;
        [_codeButton countDownButtonHandler:^(JKCountDownButton *countDownButton, NSInteger tag) {
            if (![weakSelf.phone isValidPhone]) {
                [SFHUD showInfoToast:@"请输入正确的手机号"];
                return ;
            }
//            SFSmsApi *api = [[SFSmsApi alloc] initWithPhone:weakSelf.phone smsType:SFSmsTypeRegister];
//            api.delegate = self;
//            api.hudType = SFHUDTypeProgressAlert;
//            [api start];
        }];
        
        [_codeButton countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            NSString *time = [NSString stringWithFormat:@"%zd s",second];
            return time;
        }];
        
        [_codeButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"重新获取";
        }];
    }
    return _codeButton;
}

- (YHTitleFieldView *)passwordView {
    if (!_passwordView) {
        _passwordView = [YHTitleFieldView new];
        [_passwordView configWithTitle:@"设置密码" palceHolder:@"请输入密码" showImage:[UIImage imageNamed:@"ic_password_hide"] keyBoardType:UIKeyboardTypeDefault secureTextEntry:YES];
        
         _passwordView.backgroundColor = [UIColor colorWithHexString:@"0x171C25"];
        WeakSelf;
        [_passwordView setTextChangeBlock:^(NSString *index) {
            weakSelf.password = index;
        }];
        
        [_passwordView setButtonActionBlock:^(NSInteger index) {
            if(!index){
                [weakSelf.passwordView setShowImage:[UIImage imageNamed:@"ic_password_show"] secureTextEntry:NO];
            }else{
                [weakSelf.passwordView setShowImage:[UIImage imageNamed:@"ic_password_hide"] secureTextEntry:YES];
            }
        }];
    }
    return _passwordView;
}


- (YHTitleFieldView *)confirmPasswordView {
    if (!_confirmPasswordView) {
        _confirmPasswordView = [YHTitleFieldView new];
        [_confirmPasswordView configWithTitle:@"确认密码" palceHolder:@"请再次输入密码" showImage:nil keyBoardType:UIKeyboardTypeDefault secureTextEntry:YES];
        _confirmPasswordView.backgroundColor = [UIColor colorWithHexString:@"0x171C25"];
        WeakSelf;
        [_confirmPasswordView setTextChangeBlock:^(NSString *index) {
            weakSelf.confirmPassword = index;
        }];
    }
    return _confirmPasswordView;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [self buttonWithSize:CGSizeMake(kScreenWidth - 40, 44)];
        [_confirmButton setTitle:@"提交" forState:UIControlStateNormal];
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self toCornradius:22 with:_confirmButton];
    }
    return _confirmButton;
}
@end
