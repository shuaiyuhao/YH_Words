//
//  SFTitleTextViewCell.m
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/8/15.
//  Copyright © 2019 xiaohuodui-2. All rights reserved.
//

#import "SFTitleTextViewCell.h"
#import <Masonry.h>
#import "UITextField+SFBuilder.h"
#import "UILabel+SFBuilder.h"
#import "AppMacros.h"
#import "UITextView+SFPlaceholder.h"
#import "UITextView+SFInputLimit.h"
#import "UIColor+SFUIConfig.h"

@interface SFTitleTextViewCell ()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextView *valueTextView;

@end

@implementation SFTitleTextViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueTextView];
        [self layoutPageViews];
        self.canWrite = YES;
    }
    return self;
}

- (void)layoutPageViews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(16);
    }];
    [self.valueTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.right.bottom.equalTo(self.contentView).offset(-16);
        make.left.equalTo(self.titleLabel.mas_right).offset(16);
        make.height.equalTo(@70);
    }];
    
}

+ (CGFloat)cellHeight{
    return 120.f;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)configWithData:(id)data{
    if(data && [data isKindOfClass:[SFBaseTableViewModel class]]){
        SFBaseTableViewModel *model = data;
        self.stringBlock = model.block;
        if(model.data && [model.data isKindOfClass:[NSDictionary class]]){
            NSDictionary *dic = model.data;
            if ([dic[@"isOrder"] boolValue]) {
                NSString *title = dic[@"title"];
                UIColor *titleColor = dic[@"titleColor"];
                NSString *value = dic[@"value"];
                UIColor *valueColor = dic[@"valueColor"];
                NSString *placeholder = dic[@"placeholder"];
                BOOL canEdit = [dic[@"cnaEdit"] boolValue];
                BOOL canSelect = [dic[@"canSelect"] boolValue];
                NSTextAlignment textAlignment = [dic[@"textAlignment"] integerValue];
                NSString *substringValue = dic[@"substringValue"];
                UIColor *newColorValue = dic[@"newColorValue"];
                
                
                self.titleLabel.text = title;
                self.titleLabel.textColor = titleColor;
                self.valueTextView.placeholder = placeholder;
                
                self.canEdit = canEdit;
                if(canSelect){
                    self.canSelect = YES;
                }else{
                    self.canEdit = canEdit;
                }
               
                if(self.indexPath.row){
                    [self showLineWithTop:YES bottom:NO];
                }else{
                    [self showLineWithTop:NO bottom:NO];
                }
            }
        }
    }
}

- (void)setTitle:(NSString *)title textView:(NSString *)textView{
    self.titleLabel.text = title;
    self.valueTextView.text = textView;
    self.valueTextView.layer.borderWidth = 0;
}

- (void)setTitle:(NSString *)title textView:(NSString *)textView placeholder:(NSString *)placeholder{
    self.titleLabel.text = title;
    self.valueTextView.text = textView;
    self.valueTextView.placeholder = placeholder;
}

- (void)setBorderWithTitle:(NSString *)title textView:(NSString *)textView placeholder:(NSString *)placeholder{
    [self setTitle:title textView:textView placeholder:placeholder];
    self.valueTextView.layer.borderColor = [UIColor sf_lineColor].CGColor;
    self.valueTextView.layer.borderWidth = 1;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    _textAlignment = textAlignment;
    self.valueTextView.textAlignment = textAlignment;
}

- (void)setLimit:(NSInteger)limit{
    _limit = limit;
    self.valueTextView.sf_maxLength = limit;
}

- (void)textViewDidChange:(UITextView *)textView{
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 1;// 字体的行间距
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
//                                 NSParagraphStyleAttributeName:paragraphStyle
//                                 };
//    _valueTextView.attributedText = [[NSAttributedString alloc] initWithString:_valueTextView.text attributes:attributes];
//    _valueTextView.textAlignment = self.textAlignment?:NSTextAlignmentRight;
    if(self.stringBlock){
        self.stringBlock(textView.text);
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return self.canWrite;
}

#pragma mark - getter and setter
#pragma mark -
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.builder()
        .text(@"婴子")
        .font([UIFont systemFontOfSize:14])
        .textColor([UIColor sf_fontLightBlackColor])
        .numberOfLines(1)
        .build();
    }
    return _titleLabel;
}

- (UITextView *)valueTextView{
    if(!_valueTextView){
        _valueTextView = [[UITextView alloc] init];
        _valueTextView.textContainerInset = UIEdgeInsetsMake(0,0, 0, 0);
        _valueTextView.backgroundColor = [UIColor whiteColor];
        _valueTextView.font = [UIFont systemFontOfSize:14];
        _valueTextView.textColor = [UIColor sf_fontBlackColor];
        _valueTextView.delegate = self;
        _valueTextView.textAlignment = NSTextAlignmentRight;
        _valueTextView.sf_maxLength = 9999;
        _valueTextView.keyboardType = UIKeyboardTypeDefault;
    }
    return _valueTextView;
}

@end
