//
//  YHButtonCollectionViewCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/21.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHButtonCollectionViewCell.h"
#import "UIControl+SFActionBlock.h"
#import "AppMacros.h"

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
        make.right.equalTo(self.lineView1.mas_left).offset(-28);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView2.mas_right).offset(28);
        make.centerY.equalTo(self.contentView);
    }];
}


+ (CGSize)cellSize {
    return CGSizeMake(315, 95);
}

- (void)configWithData:(id)data {
    if (data && [data isKindOfClass:[NSArray class]]) {
        [self.button1 setImage:[UIImage imageNamed:data[0][@"image"]] forState:UIControlStateNormal];
        [self.button1 setTitle:data[0][@"title"] forState:UIControlStateNormal];
        [_button1 setImagePosition:SFImagePositionTop spacing:7];
        
        [self.button2 setImage:[UIImage imageNamed:data[1][@"image"]] forState:UIControlStateNormal];
        [self.button2 setTitle:data[1][@"title"] forState:UIControlStateNormal];
        [_button2 setImagePosition:SFImagePositionTop spacing:7];
        
        [self.button3 setImage:[UIImage imageNamed:data[2][@"image"]] forState:UIControlStateNormal];
        [self.button3 setTitle:data[2][@"title"] forState:UIControlStateNormal];
        [_button3 setImagePosition:SFImagePositionTop spacing:7];
    }
}

#pragma mark - getter and setter
#pragma mark -
- (UIButton *)button1 {
    if (!_button1) {
        _button1 = UIButton.builder()
        .font([UIFont systemFontOfSize:12])
        .build();
        
        
        WeakSelf;
        [self.button1 sf_addHandler:^(id weakSender) {
            if (weakSelf.button1TappedBlock) {
                weakSelf.button1TappedBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = UIButton.builder()
        .font([UIFont systemFontOfSize:12])
        .build();
    
        WeakSelf;
        [self.button2 sf_addHandler:^(id weakSender) {
            if (weakSelf.button2TappedBlock) {
                weakSelf.button2TappedBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

- (UIButton *)button3 {
    if (!_button3) {
        _button3 = UIButton.builder()
        .font([UIFont systemFontOfSize:12])
        .build();
        
        WeakSelf;
        [self.button3 sf_addHandler:^(id weakSender) {
            if (weakSelf.button3TappedBlock) {
                weakSelf.button3TappedBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
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
