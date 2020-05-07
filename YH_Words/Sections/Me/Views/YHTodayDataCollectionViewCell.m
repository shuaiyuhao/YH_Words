//
//  YHTodayDataCollectionViewCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/21.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHTodayDataCollectionViewCell.h"

@interface YHTodayDataCollectionViewCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *numberLabel;

@end

@implementation YHTodayDataCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.numberLabel];
        
        self.contentView.layer.cornerRadius = 17;
        self.contentView.layer.borderWidth = 2;
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"0x979797"].CGColor;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"0x292d36"];
        
        [self layoutPageViews];
    }
    
    return self;
}

- (void)layoutPageViews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@55);
        make.height.equalTo(@60);
        make.top.equalTo(self.contentView.mas_top).offset(23);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(102, 2));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@75);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
}

+ (CGSize)cellSize {
    return CGSizeMake(123, 160);
}

- (void)configWithData:(id)data {
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = data;
        self.titleLabel.text = dic[@"title"];
        self.numberLabel.text = dic[@"number"];
    }
}

- (void)configTitle:(NSString *)title {
    if (title && [title isKindOfClass:[NSString class]]) {
        self.titleLabel.text = title;
    }
}

#pragma mark - getter and setter
#pragma mark -
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.builder()
        .text(@"今日推荐")
        .textColor([UIColor colorWithHexString:@"0x979797"])
        .textAlignment(NSTextAlignmentCenter)
        .numberOfLines(2)
        .font([UIFont systemFontOfSize:21 weight:UIFontWeightRegular])
        .build();
    }
    
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 102, 2)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0x979797"];
    }
    return _lineView;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = UILabel.builder()
        .text(@"100")
        .textColor([UIColor colorWithHexString:@"0xFFFFFF"])
        .textAlignment(NSTextAlignmentCenter)
        .numberOfLines(1)
        .font([UIFont systemFontOfSize:36 weight:UIFontWeightBold])
        .build();
    }
    
    return _numberLabel;
}




@end
