//
//  SFTitleValueCell.m
//  FootBath
//
//  Created by zhang on 2016/12/21.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "SFTitleValueCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "UILabel+SFFly.h"
#import "AppMacros.h"
#import "UIColor+SFUIConfig.h"
//#import "SFProductPayTypeMenulModel.h"

@interface SFTitleValueCell ()

@property (nonatomic,strong) UIImageView *iconImageView;

@property (nonatomic,strong) UIImageView *rightIconImgeView;
@property (nonatomic,strong) MASConstraint *titleLeftConstraint;

@end

@implementation SFTitleValueCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueLabel];
        [self.contentView addSubview:self.rightIconImgeView];
        [self layoutPageViews];
        
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"0x1A2635"];
        [self setBackgroundColor:[UIColor colorWithHexString:@"0x1A2635"]];
    }
    return self;
}

- (void)layoutPageViews{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        self.titleLeftConstraint = make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.left.equalTo(self.contentView).offset(16).priorityLow();
        make.centerY.equalTo(self.contentView);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(self.contentView).multipliedBy(0.65);
    }];
    [self.rightIconImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.right.equalTo(self.contentView).offset(0);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setImage:(id)image title:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder{
    if(value && value.length){
        [self setImage:image title:title value:value];
    }else{
        self.valueColor = [UIColor sf_fontLightGrayColor];
        [self setImage:image title:title value:placeholder];
    }
}

- (void)setImage:(id)image title:(NSString *)title value:(NSString *)value placeholder:(NSString *)placeholder size:(CGSize)size{
    [self setImage:image title:title value:value placeholder:placeholder];
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}

- (void)setImage:(id)image title:(NSString *)title value:(NSString *)value{
    if (image) {
        self.iconImageView.hidden = NO;
        if (self.titleLeftPadding > 0) {
            [self.titleLeftConstraint setOffset:self.titleLeftPadding];
        }
        [self.titleLeftConstraint activate];
    }else{
        [self.titleLeftConstraint deactivate];
        self.iconImageView.hidden = YES;
        
        if (self.titleLeftPadding > 0) {
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(self.titleLeftPadding);
            }];
        }
    }
    
    if ([image isKindOfClass:[UIImage class]]) {
        self.iconImageView.image = image;
    }else if ([image isKindOfClass:[NSString class]]){
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:image]];
    }
    self.titleLabel.text = title;
    self.valueLabel.text = value;
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        [self.valueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(0);
        }];
    }else if (self.accessoryType == UITableViewCellAccessoryNone){
        [self.valueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-12);
        }];
    }
    
    if (self.valueRightPadding > 0) {
        [self.valueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(- self.valueRightPadding);
        }];
    }
    
    self.rightIconImgeView.hidden = YES;
    self.valueLabel.hidden = NO;
}

- (void)setLeftImage:(id)image title:(NSString *)title value:(NSString *)value{
    [self setImage:image title:title value:value];
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(58);
            make.right.equalTo(self.contentView).offset(0);
        }];
    }else if (self.accessoryType == UITableViewCellAccessoryNone){
        [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(58);
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
}

- (void)setTitle:(NSString *)title value:(NSString *)value  padding:(CGFloat)padding{
    [self setImage:nil title:title value:value];
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(padding);
            make.right.equalTo(self.contentView).offset(0);
        }];
    }else if (self.accessoryType == UITableViewCellAccessoryNone){
        [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(padding);
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
}

- (void)setRightIcon:(UIImage *)image{
    [self setRightIcon:image size:CGSizeMake(16, 16)];
    
}

- (void)setRightIcon:(UIImage *)image size:(CGSize)size{
    if(image && [image isKindOfClass:[UIImage class]]){
        self.rightIconImgeView.image = image;
        self.rightIconImgeView.hidden = NO;
        self.valueLabel.hidden = YES;
        if(self.imageRightPadding > 0){
            [self.rightIconImgeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(- self.imageRightPadding);
                make.size.mas_equalTo(size);
            }];
        }
    }
}



+ (CGFloat)cellHeight{
    return 50.f;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

//- (void)setCanEdit:(BOOL)canEdit{
//    _canEdit = canEdit;
//    if (canEdit) {
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        self.selectionStyle = UITableViewCellSelectionStyleDefault;
//    }else{
//        self.accessoryType = UITableViewCellAccessoryNone;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//}
//
//- (void)setCanSelect:(BOOL)canSelect{
//    _canSelect = canSelect;
//    if (canSelect) {
//        self.accessoryType = UITableViewCellAccessoryNone;
//        self.selectionStyle = UITableViewCellSelectionStyleDefault;
//    }else{
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//}

- (void)setTitleFont:(UIFont *)titleFont {
    self.titleLabel.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}

- (void)setValueColor:(UIColor *)valueColor {
    self.valueLabel.textColor = valueColor;
}

- (void)setValueFont:(UIFont *)valueFont {
    self.valueLabel.font = valueFont;
}

- (void)setTitleLeftPadding:(NSInteger)titleLeftPadding {
    _titleLeftPadding = titleLeftPadding;
    //    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
    //       make.left.equalTo(self.contentView).offset(titleLeftPadding);
    //    }];
}

- (void)setValueLeftPadding:(NSInteger)valueLeftPadding{
    self.valueLabel.textAlignment = NSTextAlignmentLeft;
    [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(102);
        make.right.equalTo(self.contentView).offset(-16);
    }];
}

#pragma mark - SFTableViewComponentDelegate
#pragma mark -
+ (CGFloat)heightForData:(id)data{
    return 50.f;
}

#pragma mark - getter and setter
#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:[UIColor grayColor] fontSize:14];
    }
    return _titleLabel;
}

- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [UILabel labelWithTextColor:[UIColor grayColor] fontSize:14];
        _valueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _valueLabel;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

- (UIImageView *)rightIconImgeView{
    if (!_rightIconImgeView) {
        _rightIconImgeView = [UIImageView new];
        _rightIconImgeView.contentMode = UIViewContentModeScaleAspectFill;
        _rightIconImgeView.clipsToBounds = YES;
        _rightIconImgeView.hidden = YES;
    }
    return _rightIconImgeView;
}


@end
