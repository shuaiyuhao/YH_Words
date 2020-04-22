//
//  YHButtonCollectionViewCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/21.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHButtonCollectionViewCell.h"

@interface YHButtonCollectionViewCell ()

@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton *button3;

@property (nonatomic,strong) UIView *lineView1;
@property (nonatomic,strong) UIView *lineView2;

@end

@implementation YHButtonCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.button1];
        [self.contentView addSubview:self.button2];
        [self.contentView addSubview:self.button3];
        
        [self.contentView addSubview:self.lineView1];
        [self.contentView addSubview:self.lineView2];
        
        self.contentView.layer.cornerRadius = 17;
        self.contentView.layer.borderWidth = 2;
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"0xffffff"].CGColor;
        
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews {
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(61, 70));
        make.center.equalTo(self.contentView);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@2);
        make.height.equalTo(@56);
        make.right.equalTo(self.button2.mas_left).offset(-13);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@2);
        make.height.equalTo(@56);
        make.left.equalTo(self.button2.mas_right).offset(13);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lineView1.mas_left).offset(-23);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView2.mas_right).offset(23);
        make.centerY.equalTo(self.contentView);
    }];
}


+ (CGSize)cellSize {
    return CGSizeMake(315, 95);
}

- (void)configWithData:(id)data {
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = data;
        [_button1 setImage:[UIImage imageNamed:dic[@"image1"]] forState:UIControlStateNormal];
        [_button1 setImage:[UIImage imageNamed:dic[@"image2"]] forState:UIControlStateNormal];
        [_button1 setImage:[UIImage imageNamed:dic[@"image3"]] forState:UIControlStateNormal];
    }
}

#pragma mark - getter and setter
#pragma mark -
- (UIButton *)button1 {
    if (!_button1) {
        _button1 = UIButton.builder()
        .image([UIImage imageNamed:@"ic_smile"])
        .title(@"记忆单词")
        .font([UIFont systemFontOfSize:12])
        .build();
        
        [_button1 setImagePosition:SFImagePositionTop spacing:7];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = UIButton.builder()
        .image([UIImage imageNamed:@"ic_cry"])
        .title(@"模糊单词")
        .font([UIFont systemFontOfSize:12])
        .build();
        
        [_button2 setImagePosition:SFImagePositionTop spacing:7];
    }
    return _button2;
}

- (UIButton *)button3 {
    if (!_button3) {
        _button3 = UIButton.builder()
        .image([UIImage imageNamed:@"ic_like"])
        .title(@"收藏单词")
        .font([UIFont systemFontOfSize:12])
        .build();
        
        [_button3 setImagePosition:SFImagePositionTop spacing:7];
    }
    return _button3;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 56)];
        _lineView1.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    }
    return _lineView1;
}


- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 56)];
        _lineView2.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    }
    return _lineView2;
}

@end
