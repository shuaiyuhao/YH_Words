//
//  YHRegisterController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/4.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHRegisterController.h"
#import "YHTitleFieldView.h"
#import <JKCountDownButton.h>
#import "UIColor+SFUIConfig.h"
#import "YHRegisterApi.h"
#import "YHLoginApi.h"
#import "YHUserModel.h"
#import "YHUserManager.h"
#import "YHTabBarController.h"

@interface YHRegisterController ()<YTKRequestDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) YHTitleFieldView *phoneView;
@property (nonatomic,strong) YHTitleFieldView *codeView;
@property (nonatomic,strong) YHTitleFieldView *passwordView;
@property (nonatomic,strong) YHTitleFieldView *confirmPasswordView;
@property (nonatomic,strong) YHTitleFieldView *userNameView;
@property (nonatomic,strong) UIButton *registerButton;
@property (nonatomic,strong) JKCountDownButton *codeButton;

@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *confirmPassword;
@property (nonatomic,copy) NSString *userName;

@end

@implementation YHRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新用户注册";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.view.backgroundColor = [UIColor colorWithHexString:@"0x171C25"];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.phoneView];
//    [self.view addSubview:self.codeView];
    [self.view addSubview:self.passwordView];
    [self.view addSubview:self.confirmPasswordView];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.userNameView];
    
    
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
    
//    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 44));
//        make.top.equalTo(self.phoneView.mas_bottom).offset(8);
//        make.centerX.equalTo(self.view);
//    }];
    
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 44));
        make.top.equalTo(self.phoneView.mas_bottom).offset(8);
        make.centerX.equalTo(self.view);
    }];
    
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 44));
        make.top.equalTo(self.userNameView.mas_bottom).offset(8);
        make.centerX.equalTo(self.view);
    }];
    
    [self.confirmPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 44));
        make.top.equalTo(self.passwordView.mas_bottom).offset(8);
        make.centerX.equalTo(self.view);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40, 44));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.confirmPasswordView.mas_bottom).offset(140);
    }];
}

- (void)registerUser {
    if (![self.phone isValidPhone]) {
        [SFHUD showInfoToast:@"请输入正确的手机号"];
        return ;
    }
    
    if (!self.userName.length) {
        [SFHUD showInfoToast:@"请输入用户名"];
        return;
    }
    
    if(!self.password){
        [SFHUD showInfoToast:@"请设置密码"];
        return;
    }
    
    if (![self.password isEqualToString:self.confirmPassword]) {
        [SFHUD showInfoToast:@"密码不一致，请输入相同密码"];
        return;
    }
    
    [SFHUD showProgressAlert];
//    SFRegisterApi *api = [[SFRegisterApi alloc] initWithPhone:self.phone code:self.code password:self.password];
//    api.delegate = self;
//    [api start];
    
    YHRegisterApi *api = [[YHRegisterApi alloc] initWithPhone:self.phone username:self.userName passwd:self.confirmPassword];
    NSLog(@"%@",self.confirmPassword);
    api.delegate = self;
    [api start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneView resignFirstResponder];
    [self.userNameView resignFirstResponder];
    [self.passwordView resignFirstResponder];
    [self.confirmPasswordView resignFirstResponder];
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
}

#pragma mark - YTKRequestDelegate
#pragma mark -
- (void)requestFinished:(__kindof YTKBaseRequest *)request {
    id obj = request.responseObject;
    id data = [(SFBaseApiRequest *)request fetchDataWithReformer:nil];
    if (![(SFBaseApiRequest *)request success]) {
        
        NSLog(@"注册错误");
        [SFHUD showToast:obj[@"message"]];
        return;
    }
    
    if ([(SFBaseApiRequest *)request isKindOfClass:[YHRegisterApi class]]) {
        NSLog(@"%@",data);
        YHLoginApi *api = [[YHLoginApi alloc] initWithPhone:self.phone passwd:self.confirmPassword];
        api.delegate = self;
        api.hudType = SFHUDTypeProgressAlert;
        [api start];
    }
    
    if ([(SFBaseApiRequest *)request isKindOfClass:[YHLoginApi class]]) {
        [SFHUD hideAlert];
        [SFHUD showSuccessToast:@"注册成功！"];
        
        YHUserModel *model = [YHUserModel yy_modelWithJSON:data];
        [[YHUserManager sharedManager] updateUserInfo:model];
        
        YHTabBarController *vc = [YHTabBarController new];
        [ApplicationDelegate setRootViewController:vc animated:true];
    }
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request {
    [SFHUD hideAlert];
    NSDictionary *data = [(SFBaseApiRequest *)request fetchDataWithReformer:nil];
    if (![[(SFBaseApiRequest *)request errorMsg] length]) {
        [SFHUD showToast:data[@"message"]];
    }
}


#pragma mark - getter and setter
#pragma mark -
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.builder()
        .text(@"注册用户")
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

- (YHTitleFieldView *)userNameView {
    if (!_userNameView) {
        _userNameView = [YHTitleFieldView new];
        [_userNameView configWithTitle:@"用户名" palceHolder:@"请输入用户名" showImage:nil keyBoardType:UIKeyboardTypeDefault secureTextEntry:NO];
        _userNameView.backgroundColor = [UIColor colorWithHexString:@"0x171c25"];
        
        WeakSelf;
        [_userNameView setTextChangeBlock:^(NSString *index) {
            weakSelf.userName = index;
        }];
    }
    return _userNameView;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [self buttonWithSize:CGSizeMake(kScreenWidth - 40, 44)];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self toCornradius:22 with:_registerButton];
        
        WeakSelf;
        [_registerButton sf_addHandler:^(id weakSender) {
            [weakSelf registerUser];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
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
@end
