//
//  YHTodayBrowseCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/21.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHTodayBrowseCell.h"

@interface YHTodayBrowseCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *numberLabel;

@end

@implementation YHTodayBrowseCell
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
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(30);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(2, 50));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right).offset(35);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 30));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.lineView.mas_right).offset(35);
    }];
}


+ (CGSize)cellSize {
    return CGSizeMake(315, 85);
}

- (void)configWithData:(id)data {
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = data;
        self.titleLabel.text = dic[@"title"];
        self.numberLabel.text = dic[@"number"];
    }
}
#pragma mark - getter and setter
#pragma mark -
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.builder()
        .text(@"今日浏览")
        .textColor([UIColor colorWithHexString:@"0x979797"])
        .textAlignment(NSTextAlignmentCenter)
        .numberOfLines(1)
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
        .text(@"520")
        .textColor([UIColor colorWithHexString:@"0xFFFFFF"])
        .textAlignment(NSTextAlignmentCenter)
        .numberOfLines(1)
        .font([UIFont systemFontOfSize:36 weight:UIFontWeightBold])
        .build();
    }
    
    return _numberLabel;
}

@end
