//
//  YHLoginController.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/12.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHLoginController.h"
#import "YHTitleFieldView.h"
#import "YHLoginApi.h"
#import "YHUserModel.h"
#import "YHRegisterController.h"
#import "YHTabBarController.h"

@interface YHLoginController ()<YTKRequestDelegate>


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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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
         make.size.mas_equalTo(CGSizeMake(100, 100));
         make.centerX.equalTo(self.view);
         make.top.equalTo(self.view).offset(100);
     }];
     
     [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40 , 44));
         make.centerX.equalTo(self.view);
         make.top.equalTo(self.avatarImageView.mas_bottom).offset(89);
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - YTKRequestDelegate
#pragma mark -
- (void)requestFinished:(__kindof YTKBaseRequest *)request {
    id data0 = request.responseObject;
    NSLog(@"%@",data0);
    id data = [(SFBaseApiRequest *)request fetchDataWithReformer:nil];
    
    if (![(SFBaseApiRequest *)request success]) {
        
        NSLog(@"登录错误");
        [SFHUD showToast:data0[@"message"]];
        return;
    }
    if ([(YTKBaseRequest *)request isKindOfClass:[YHLoginApi class]]) {
        [SFHUD showToast:@"登录成功"];
        YHUserModel *model = [YHUserModel yy_modelWithJSON:data];
        
        NSLog(@"%@",model);
        [[YHUserManager sharedManager] updateUserInfo:model];
        
        
        YHTabBarController *vc = [YHTabBarController new];
        [ApplicationDelegate setRootViewController:vc animated:YES];
    }
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request {
    NSDictionary *data = [(SFBaseApiRequest *)request fetchDataWithReformer:nil];
      if (![[(SFBaseApiRequest *)request errorMsg] length]) {
          [SFHUD showToast:data[@"message"]];
      }
}
#pragma mark - getter and setter
#pragma mark -
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        
         [self toCornradius:40 with:_avatarImageView];
    }
    
    return _avatarImageView;
}

- (YHTitleFieldView *)accountView {
    if (!_accountView) {
        _accountView = [[YHTitleFieldView alloc] init];
        [_accountView configWithTitle:@"账号" palceHolder:@"请输入手机号/用户名" showImage:nil keyBoardType:UIKeyboardTypeDefault secureTextEntry:NO];
        
        _accountView.backgroundColor = [UIColor clearColor];
        WeakSelf;
        [_accountView setTextChangeBlock:^(NSString *index) {
            weakSelf.account = index;
        }];
    }
    return _accountView;
}

- (YHTitleFieldView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[YHTitleFieldView alloc] init];
        [_passwordView configWithTitle:@"密码" palceHolder:@"请输入密码" showImage:[UIImage imageNamed:@"eye_close"] keyBoardType:UIKeyboardTypeDefault secureTextEntry:YES];
        _passwordView.backgroundColor = [UIColor clearColor];
        WeakSelf;
        [_passwordView setButtonActionBlock:^(NSInteger index) {
            if (!index) {
                [weakSelf.passwordView setShowImage:[UIImage imageNamed:@"eye_open"] secureTextEntry:NO];
            } else {
                [weakSelf.passwordView setShowImage:[UIImage imageNamed:@"eye_close"] secureTextEntry:YES];
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
        
//        WeakSelf;
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
        [_registerButton sf_addHandler:^(id weakSender) {
            
            YHRegisterController *vc = [YHRegisterController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            NSLog(@">>>>>>>>>>>");
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [self buttonWithSize:CGSizeMake(kScreenWidth - 40, 44)];
        [_loginButton setTitle:@"立即登陆" forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self toCornradius:22 with:_loginButton];
        
        WeakSelf;
        [_loginButton sf_addHandler:^(id weakSender) {
            if (![self.account isValidPhone]) {
                [SFHUD showInfoToast:@"请输入正确的手机号"];
                return ;
            }
            if (!self.password.length) {
                [SFHUD showInfoToast:@"请输入密码"];
                return ;
            }
//            SFLoginApi *api = [[SFLoginApi alloc] initWithAccount:weakSelf.account password:weakSelf.password];
//            api.delegate = weakSelf;
//            api.hudType = SFHUDTypeProgressAlert;
//            [api start];
//            SFTabBarController *vc = [SFTabBarController new];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//            [ApplicationDelegate setRootViewController:vc animated:YES];
            YHLoginApi *api = [[YHLoginApi alloc]initWithPhone:self.account passwd:self.password];
            NSLog(@"%@,%@",self.account,self.password);
            api.delegate = self;
            api.hudType = SFHUDTypeProgressAlert;
            [api start];
            
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
@end
