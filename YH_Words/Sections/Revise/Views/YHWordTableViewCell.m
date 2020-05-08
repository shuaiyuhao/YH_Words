//
//  YHWordTableViewCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/26.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHWordTableViewCell.h"
#import <Masonry.h>
#import "UILabel+SFBuilder.h"
#import "UIColor+SFAdd.h"
#import "WordDataModel.h"

@interface YHWordTableViewCell ()

@property (nonatomic,strong) UILabel *engLabel;
@property (nonatomic,strong) UILabel *zhLabel;

@end

@implementation YHWordTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:@"0x292D36"]];
        
        [self.contentView addSubview:self.engLabel];
        [self.contentView addSubview:self.zhLabel];
        
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews {
    [self.engLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 20));
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(20);
    }];
    
    [self.zhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(280, 20));
        make.bottom.equalTo(self.contentView).offset(-3);
        make.left.equalTo(self.contentView).offset(20);
    }];
}

+ (CGFloat)cellHeight {
    return 55.f;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

- (void)configWithData:(id)data {
    if (data && [data isKindOfClass:[WordDataModel class]]) {
        
        WordDataModel *model = data;
        
        self.engLabel.text = model.word;
        self.zhLabel.text = model.chinese;
    }
}
#pragma mark - getter and setter
#pragma mark -
- (UILabel *)engLabel {
    if (!_engLabel) {
        _engLabel = UILabel.builder()
        .text(@"")
        .textColor([UIColor colorWithHexString:@"0xACB0B5"])
        .textAlignment(NSTextAlignmentLeft)
        .font([UIFont systemFontOfSize:17])
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _engLabel;
}

- (UILabel *)zhLabel {
    if (!_zhLabel) {
        _zhLabel = UILabel.builder()
        .text(@"")
        .textColor([UIColor colorWithHexString:@"0xACB0B5"])
        .textAlignment(NSTextAlignmentLeft)
        .font([UIFont systemFontOfSize:14])
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _zhLabel;
}
@end
