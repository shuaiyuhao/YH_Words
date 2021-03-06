//
//  YHWordCardCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/22.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHWordCardCell.h"
#import "UILabel+SFBuilder.h"
#import <Masonry.h>
#import "UIColor+SFAdd.h"
#import "WordDataModel.h"
#import "UIButton+SFBuilder.h"

@interface YHWordCardCell ()

@property (nonatomic,strong) UILabel *wordLabel;
@property (nonatomic,strong) UILabel *phoneticLabel;
@property (nonatomic,strong) UILabel *paraphraseTitleLabel;
@property (nonatomic,strong) UILabel *paraphraseLabel;
@property (nonatomic,strong) UILabel *exampleTitileLabel;
@property (nonatomic,strong) UILabel *exampleLabel;
//发声按钮
@property (nonatomic,strong) UIButton *soundButton;

@end

@implementation YHWordCardCell
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"0x292D36"];
        self.layer.cornerRadius = 17;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithHexString:@"0x979797"].CGColor;
        self.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.wordLabel];
        [self.contentView addSubview:self.phoneticLabel];
        [self.contentView addSubview:self.paraphraseTitleLabel];
        [self.contentView addSubview:self.paraphraseLabel];
        [self.contentView addSubview:self.exampleTitileLabel];
        [self.contentView addSubview:self.exampleLabel];
        [self.contentView addSubview:self.soundButton];
        
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews {
    [self.wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(280, 67));
        make.top.equalTo(self.contentView).offset(22);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.phoneticLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(240, 30));
        make.top.equalTo(self.wordLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.paraphraseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 25));
        make.left.equalTo(self.contentView).offset(30);
        make.top.equalTo(self.phoneticLabel.mas_bottom).offset(30);
    }];
    
    [self.paraphraseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(240, 25));
        make.left.equalTo(self.contentView).offset(30);
        make.top.equalTo(self.paraphraseTitleLabel.mas_bottom).offset(12);
    }];
    
    [self.exampleTitileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(40, 25));
          make.left.equalTo(self.contentView).offset(30);
          make.top.equalTo(self.paraphraseLabel.mas_bottom).offset(24);
      }];
    
    [self.exampleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(240, 60));
          make.left.equalTo(self.contentView).offset(30);
          make.top.equalTo(self.exampleTitileLabel.mas_bottom).offset(12);
      }];
    
    [self.soundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
}

- (void)configWithData:(id)data {
    if (data && [data isKindOfClass:[WordDataModel class]]) {
        
        WordDataModel *model = data;
        self.wordLabel.text = model.word;
        self.phoneticLabel.text = model.phonetic;
        self.paraphraseLabel.text = model.chinese;
        self.exampleLabel.text = model.example;
    }
}

- (void)soundButtonClick {
    if ([self.delegate respondsToSelector:@selector(cardViewCell:soundText:)]) {
        [self.delegate cardViewCell:self soundText:self.wordLabel.text];
    }
}

#pragma mark - getter and setter
#pragma mark -
- (UILabel *)wordLabel {
    if (!_wordLabel) {
        _wordLabel = UILabel.builder()
        .text(@"artist")
        .textColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:48])
        .textAlignment(NSTextAlignmentCenter)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _wordLabel;
}

- (UILabel *)phoneticLabel {
    if (!_phoneticLabel) {
        _phoneticLabel = UILabel.builder()
        .text(@"/'a:tist/")
        .textColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:24])
        .textAlignment(NSTextAlignmentCenter)
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _phoneticLabel;
}

- (UILabel *)paraphraseTitleLabel {
    if (!_paraphraseTitleLabel) {
        _paraphraseTitleLabel = UILabel.builder()
        .text(@"释义")
        .textColor([UIColor whiteColor])
        .textAlignment(NSTextAlignmentLeft)
        .font([UIFont systemFontOfSize:18])
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _paraphraseTitleLabel;
}

- (UILabel *)paraphraseLabel {
    if (!_paraphraseLabel) {
        _paraphraseLabel = UILabel.builder()
        .text(@"n.艺术家；美术家；艺人")
        .textColor([UIColor whiteColor])
        .textAlignment(NSTextAlignmentLeft)
        .font([UIFont systemFontOfSize:18])
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _paraphraseLabel;
}

- (UILabel *)exampleTitileLabel {
    if (!_exampleTitileLabel) {
        _exampleTitileLabel = UILabel.builder()
        .text(@"列句")
        .textColor([UIColor whiteColor])
        .textAlignment(NSTextAlignmentLeft)
        .font([UIFont systemFontOfSize:18])
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _exampleTitileLabel;
}

- (UILabel *)exampleLabel {
    if (!_exampleLabel) {
        _exampleLabel = UILabel.builder()
        .text(@"Each_poster_is_signed_by_the_artist.")
        .textColor([UIColor whiteColor])
        .textAlignment(NSTextAlignmentLeft)
        .numberOfLines(3)
        .font([UIFont systemFontOfSize:18])
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _exampleLabel;
}

- (UIButton *)soundButton {
    if (!_soundButton) {
        _soundButton = UIButton.builder()
        .image([UIImage imageNamed:@"sound"])
        .build();

        [_soundButton addTarget:self action:@selector(soundButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _soundButton;
}
@end
