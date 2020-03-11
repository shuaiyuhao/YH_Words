//
//  YHLoginController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/12.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHLoginController.h"
#import "YHTitleFieldView.h"

@interface YHLoginController ()

@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) YHTitleFieldView *accountView;
@property (nonatomic,strong) YHTitleFieldView *passwordView;

@property (nonatomic,strong) UIButton *forgetButton;
@property (nonatomic,strong) UIButton *registerButton;
@property (nonatomic,strong) UIButton *loginButton;

@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *password;
@end

@implementation YHLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"YHWords";
    self.view.backgroundColor = [UIColor colorWithHexString:@"0x171C25"];
    
    [self.view addSubview:self.avatarImageView];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.passwordView];
    
    [self.view addSubview:self.forgetButton];
      [self.view addSubview:self.registerButton];
      [self.view addSubview:self.loginButton];
      
      [self layoutPageViews];
}

- (void)layoutPageViews {
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(80, 80));
         make.centerX.equalTo(self.view);
         make.top.equalTo(self.view).offset(60);
     }];
     
     [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40 , 44));
         make.centerX.equalTo(self.view);
         make.top.equalTo(self.avatarImageView.mas_bottom).offset(39);
     }];
     
     [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40 , 44));
         make.centerX.equalTo(self.view);
         make.top.equalTo(self.accountView.mas_bottom).offset(8);
     }];
     
     [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.view).offset(20);
         make.top.equalTo(self.passwordView.mas_bottom).offset(20);
     }];
     
     [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.forgetButton);
         make.right.equalTo(self.view).offset(-20);
     }];
     
     [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 44));
         make.centerX.equalTo(self.view);
         make.top.equalTo(self.forgetButton.mas_bottom).offset(64);
     }];
}

#pragma mark - getter and setter
#pragma mark -
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        
         [self toCornradius:40 with:_avatarImageView];
    }
    
    return _avatarImageView;
}

- (YHTitleFieldView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[YHTitleFieldView alloc] init];
        [_passwordView configWithTitle:@"密码" palceHolder:@"请输入密码" showImage:[UIImage imageNamed:@"ic_password_hide"] keyBoardType:UIKeyboardTypeDefault secureTextEntry:YES];
        
        WeakSelf;
        [_passwordView setButtonActionBlock:^(NSInteger index) {
            if (!index) {
                [weakSelf.passwordView setShowImage:[UIImage imageNamed:@"ic_password_show"] secureTextEntry:NO];
            } else {
                [weakSelf.passwordView setShowImage:[UIImage imageNamed:@"ic_password_hide"] secureTextEntry:YES];
            }
        }];
        
        [_passwordView setTextChangeBlock:^(NSString *index) {
            weakSelf.password = index;
        }];
    }
    return _passwordView;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = UIButton.builder()
        .title(@"忘记密码")
        .titleColor([UIColor colorWithHexString:@"0x999999"])
        .backgroundColor([UIColor clearColor])
        .font([UIFont systemFontOfSize:14])
        .build();
        
        WeakSelf;
//        [_forgetButton sf_addHandler:^(id weakSender) {
////            UIViewController *vc = [[CTMediator sharedInstance] login_forgetpassword:@{}];
////            SFEnterpriseQualificationController *vc = [SFEnterpriseQualificationController new];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}

- (UIButton *)registerButton{
    if (!_registerButton) {
        _registerButton = UIButton.builder()
        .title(@"新用户注册")
        .titleColor([UIColor colorWithHexString:@"0x1890EF"])
        .backgroundColor([UIColor clearColor])
        .font([UIFont systemFontOfSize:14])
        .build();
        
        WeakSelf;
//        [_registerButton sf_addHandler:^(id weakSender) {
////            UIViewController *vc = [[CTMediator sharedInstance] login_register:@{}];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//            NSLog(@">>>>>>>>>>>");
//        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

@end
