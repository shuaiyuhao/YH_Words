//
//  YHMeSettingCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/3.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHMeSettingCell.h"
#import <Masonry.h>
#import "UILabel+SFBuilder.h"
#import "UIColor+SFAdd.h"
#import <SDWebImage.h>

@interface YHMeSettingCell ()

@end

@implementation YHMeSettingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self.contentView addSubview:self.userImageView];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.userIDLabel];
        [self layoutPageViews];
        
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"0x1A2635"];

    }
    
    return self;
}

- (void)layoutPageViews {
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(11);
        make.left.equalTo(self.userImageView.mas_right).offset(12);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView).offset(-16);
    }];
    
    [self.userIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(2);
        make.left.equalTo(self.userImageView.mas_right).offset(12);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.contentView).offset(-16);
    }];
    
}

+ (CGFloat)cellHeight{
    return 60.f;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)configWithData:(id)data{
//    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[SFUserManager sharedManager].avatar.length?[SFUserManager sharedManager].avatar:@""]];
//    self.userNameLabel.text =
}

- (void)configWithName:(NSString *)name userId:(NSInteger)userId avatar:(nonnull NSString *)avatar{
    self.userIDLabel.text = [NSString stringWithFormat:@"用户ID:%ld",userId];
    self.userNameLabel.text = name;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://129.211.95.89%@",avatar]]];
}



#pragma mark - getter and setter
#pragma mark -

- (UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _userImageView.layer.cornerRadius = 20;
        _userImageView.layer.masksToBounds = YES;
        _userImageView.contentMode = UIViewContentModeScaleToFill;
        
//        [_userImageView sd_setImageWithURL:[NSURL URLWithString:[SFUserManager sharedManager].avatar.length?[SFUserManager sharedManager].avatar:@""]];
        
    }
    return _userImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = UILabel.builder()
        .text(@"Vwidea")
        .textColor([UIColor grayColor])
        .font([UIFont systemFontOfSize:14 weight:UIFontWeightRegular])
        .textAlignment(NSTextAlignmentLeft)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _userNameLabel;
}

- (UILabel *)userIDLabel {
    if (!_userIDLabel) {
        _userIDLabel = UILabel.builder()
        .text(@"UUID:123456789")
        .textColor([UIColor grayColor])
        .font([UIFont systemFontOfSize:12 weight:UIFontWeightRegular])
        .textAlignment(NSTextAlignmentLeft)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _userIDLabel;
}
@end
