//
//  SFTextViewCell.m
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/19.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import "SFTextViewCell.h"
#import <Masonry.h>
#import "UITextField+SFBuilder.h"
#import "UILabel+SFBuilder.h"
#import "AppMacros.h"
#import "UITextView+SFPlaceholder.h"
#import "UITextView+SFInputLimit.h"

@interface SFTextViewCell ()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextView *valueTextView;

@end

@implementation SFTextViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueTextView];
        [self layoutPageViews];
        
        self.textViewCanEdit = YES;
    }
    return self;
}

- (void)layoutPageViews{
    [self.valueTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(4);
        make.right.bottom.equalTo(self.contentView).offset(-4);
    }];

}

+ (CGFloat)cellHeight{
    return 120.f;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)configWithData:(id)data {
    
}

- (void)setTitle:(NSString *)title placeholder:(NSString *)placeholder{
    self.valueTextView.text = title;
    self.valueTextView.placeholder = placeholder;
}

- (void)setBorderWithTitle:(NSString *)title placeholder:(NSString *)placeholder{
    [self setTitle:title placeholder:placeholder];
    self.valueTextView.layer.borderWidth = 1;
    self.valueTextView.layer.borderColor = [UIColor colorWithHexString:@"0xE8E8E8"].CGColor;
    [self.valueTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(16);
        make.right.bottom.equalTo(self.contentView).offset(-16);
    }];
}

- (void)setTextViewText:(NSString *)text {
    self.valueTextView.text = text;
}

- (void)textViewDidChange:(UITextView *)textView{
    if(self.stringBlock){
        self.stringBlock(textView.text);
    }
}

- (void)setTextViewCanedit:(BOOL)textViewCanEdit {
    [self.valueTextView setEditable:textViewCanEdit];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return self.textViewCanEdit;
}

#pragma mark - getter and setter
#pragma mark -
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.builder()
        .text(@"婴子")
        .font([UIFont systemFontOfSize:14])
        .textColor([UIColor colorWithHexString:@"0x666666"])
        .numberOfLines(1)
        .build();
    }
    return _titleLabel;
}

- (UITextView *)valueTextView{
    if(!_valueTextView){
        _valueTextView = [[UITextView alloc] init];
        _valueTextView.textContainerInset = UIEdgeInsetsMake(12,12, 12, 12);
        _valueTextView.backgroundColor = [UIColor whiteColor];
        _valueTextView.font = [UIFont systemFontOfSize:14];
        _valueTextView.textColor = [UIColor colorWithHexString:@"0x333333"];
        _valueTextView.delegate = self;
    }
    return _valueTextView;
}


@end
