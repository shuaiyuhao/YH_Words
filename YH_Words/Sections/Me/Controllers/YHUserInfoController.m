//
//  YHUserInfoController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/9.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHUserInfoController.h"
#import <SDWebImage.h>

@interface YHUserInfoController ()

@property (nonatomic,strong) UIView *userInfoView;
@property (nonatomic,strong) UIImageView *avatarView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *idLabel;
@property (nonatomic,strong) UILabel *levelLabel;
@property (nonatomic,strong) UILabel *infoLabel;

@property (nonatomic,strong) UIView *rememberInfoView;
@property (nonatomic,strong) UILabel *sevendayRemLabel;
@property (nonatomic,strong) UILabel *sevendayFuzLabel;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation YHUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
    [self.view addSubview:self.userInfoView];
    [self.view addSubview:self.rememberInfoView];
    
    [self layoutPageViews];
}

- (void)layoutPageViews {
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40, 220));
        make.top.equalTo(self.view).offset(30);
        make.centerX.equalTo(self.view);
    }];
    
    [self.rememberInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 110));
        make.top.equalTo(self.userInfoView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
    }];
}


#pragma mark - getter and setter
#pragma mark -
- (UIView *)userInfoView {
    if (!_userInfoView) {
        _userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
        _userInfoView.backgroundColor = [UIColor colorWithHexString:@"0x292d36"];
        _userInfoView.layer.borderColor = [UIColor colorWithHexString:@"0x979797"].CGColor;
        _userInfoView.layer.borderWidth = 1;
        
        [_userInfoView addSubview:self.avatarView];
        [_userInfoView addSubview:self.nameLabel];
        [_userInfoView addSubview:self.idLabel];
        [_userInfoView addSubview:self.levelLabel];
        [_userInfoView addSubview:self.infoLabel];
        
        
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55, 55));
            make.top.equalTo(self.userInfoView).offset(15);
            make.left.equalTo(self.userInfoView).offset(15);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@180);
            make.height.equalTo(@20);
            make.top.equalTo(self.avatarView).offset(0);
            make.left.equalTo(self.avatarView.mas_right).offset(10);
        }];
        
        [self.idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@20);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(15);
            make.left.equalTo(self.avatarView.mas_right).offset(10);
        }];
        
        [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@150);
            make.height.equalTo(@20);
            make.bottom.equalTo(self.userInfoView).offset(-15);
            make.left.equalTo(self.userInfoView).offset(10);
        }];
        
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@150);
            make.height.equalTo(@20);
            make.top.equalTo(self.levelLabel).offset(0);
            make.left.equalTo(self.levelLabel.mas_right).offset(10);
        }];
        
        [self toCornradius:12 with:_userInfoView];
    }
    return _userInfoView;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [UIImageView new];
        _avatarView.clipsToBounds = YES;
        _avatarView.contentMode = UIViewContentModeScaleAspectFill;
        
         [self.avatarView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://129.211.95.89%@",[YHUserManager sharedManager].avatar]]];
        
        [self toCornradius:12 with:_avatarView];
    }
    return _avatarView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = UILabel.builder()
        .text([NSString stringWithFormat:@"用户名：%@",[YHUserManager sharedManager].userName])
        .textColor([UIColor grayColor])
        .font([UIFont systemFontOfSize:14 weight:UIFontWeightRegular])
        .textAlignment(NSTextAlignmentLeft)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _nameLabel;
}

- (UILabel *)idLabel {
    if (!_idLabel) {
        _idLabel = UILabel.builder()
        .text([NSString stringWithFormat:@"用户ID：%ld",[YHUserManager sharedManager].userId])
        .textColor([UIColor grayColor])
        .font([UIFont systemFontOfSize:12 weight:UIFontWeightRegular])
        .textAlignment(NSTextAlignmentLeft)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _idLabel;
}

- (UILabel *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = UILabel.builder()
        .text([NSString stringWithFormat:@"当前用户等级：%ld级",[YHUserManager sharedManager].level])
        .textColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:15 weight:UIFontWeightRegular])
        .textAlignment(NSTextAlignmentLeft)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _levelLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        NSInteger *num = 0;
        _infoLabel = UILabel.builder()
        .text([NSString stringWithFormat:@"升级还需记忆 %d个单词",num])
        .textColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:13 weight:UIFontWeightRegular])
        .textAlignment(NSTextAlignmentLeft)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _infoLabel;
}

- (UIView *)rememberInfoView {
    if (!_rememberInfoView) {
        _rememberInfoView = [UIView new];
        
        _rememberInfoView.backgroundColor = [UIColor colorWithHexString:@"0x292d36"];
        _rememberInfoView.layer.borderColor = [UIColor colorWithHexString:@"0x979797"].CGColor;
        _rememberInfoView.layer.borderWidth = 1;
        
        [self toCornradius:14 with:_rememberInfoView];
        
        [_rememberInfoView addSubview:self.sevendayRemLabel];
        [_rememberInfoView addSubview:self.sevendayFuzLabel];
        [_rememberInfoView addSubview:self.lineView];
        
        [self.sevendayRemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 120));
            make.centerY.equalTo(self.rememberInfoView);
            make.left.equalTo(self.rememberInfoView).offset(17);
        }];
        
        [self.sevendayFuzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.size.mas_equalTo(CGSizeMake(150, 120));
                   make.centerY.equalTo(self.rememberInfoView);
                   make.right.equalTo(self.rememberInfoView).offset(-17);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(2, 56));
            make.centerY.equalTo(self.rememberInfoView);
            make.centerX.equalTo(self.rememberInfoView);
        }];
    }
    return _rememberInfoView;
}

- (UILabel *)sevendayRemLabel {
    if (!_sevendayRemLabel) {
        
        NSString *num = @"56";
        _sevendayRemLabel = UILabel.builder()
        .text([NSString stringWithFormat:@"%@ 个\n最近七天累计记忆",num])
        .textColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:15 weight:UIFontWeightRegular])
        .textAlignment(NSTextAlignmentCenter)
        .numberOfLines(2)
        .lineSpacing(5)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _sevendayRemLabel;
}

- (UILabel *)sevendayFuzLabel {
    if (!_sevendayFuzLabel) {
         NSString *num = @"45";
        _sevendayFuzLabel = UILabel.builder()
        .text([NSString stringWithFormat:@"%@ 个\n最近七天累计模糊",num])
        .textColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:15 weight:UIFontWeightRegular])
        .textAlignment(NSTextAlignmentCenter)
        .numberOfLines(2)
        .lineSpacing(5)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _sevendayFuzLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 56)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    }
    return _lineView;
}
@end
