//
//  YHSearchWordController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/23.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHSearchWordController.h"
#import "YHSearchWordApi.h"
#import "UITextView+SFPlaceholder.h"
#import "UITextView+SFInputLimit.h"

@interface YHSearchWordController ()<YTKRequestDelegate, UITextViewDelegate>

@property (nonatomic,strong) UITextField *inputTextField;

@property (nonatomic,strong) UIButton *searchButton;

@property (nonatomic,strong) NSString *word;

@property (nonatomic,strong) UILabel *ChineseTitleLabel;
@property (nonatomic,strong) UILabel *ChineseLabel;
@property (nonatomic,strong) NSString *translate;

@property (nonatomic,strong) UITextView *engTextView;
@property (nonatomic,strong) UITextView *zhTextView;


@end

@implementation YHSearchWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
//    [self.view addSubview:self.inputTextField];
   
//    [self.view addSubview:self.ChineseTitleLabel];
//    [self.view addSubview:self.ChineseLabel];
    
    [self.view addSubview:self.engTextView];
    [self.view addSubview:self.zhTextView];
    [self.view addSubview:self.searchButton];
    
    [self layoutPageViews];
    
}

- (void)layoutPageViews {
//    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(260, 40));
//        make.left.equalTo(self.view).offset(30);
//        make.top.equalTo(self.view).offset(30);
//    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 25));
        make.right.equalTo(self.engTextView.mas_right).offset(-10);
        make.bottom.equalTo(self.engTextView.mas_bottom).offset(-10);
    }];
    
//    [self.ChineseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(180, 60));
//        make.top.equalTo(self.inputTextField.mas_bottom).offset(20);
//        make.left.equalTo(self.view).offset(30);
//    }];
//
//    [self.ChineseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(180, 70));
//        make.top.equalTo(self.ChineseTitleLabel.mas_bottom).offset(25);
//        make.left.equalTo(self.view).offset(20);
//    }];
    
    [self.engTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 260));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(30);
    }];
    
    [self.zhTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 260));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.engTextView.mas_bottom).offset(30);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.engTextView resignFirstResponder];
    
    [self.zhTextView resignFirstResponder];
}

#pragma mark - YTKRequestDelegate
#pragma mark -
- (void)requestFinished:(__kindof YTKBaseRequest *)request {
    if ([request.responseObject isKindOfClass:[NSDictionary class]]) {
        id data = request.responseObject;
        NSLog(@"%@", data);
        
        self.translate = data[@"trans_result"][0][@"dst"];
    }
    
    self.zhTextView.text = self.translate;

}

#pragma mark - UITextViewDelegate
#pragma amrk -
//- (void)textFieldDidChange:(UITextField *)sender {
//    self.word = sender.text;
//    NSLog(@"%@",sender.text);
//}

//- (void)textViewDidChange:(UITextView *)textView {
//    if (textView.text.length > 800) {
//        textView.text = [textView.text substringToIndex:800];
//    }
//
//    self.word = textView.text;
////    self.content = textView.text;
////    self.placeHolderLabel.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)[textView.text length], 800];
//}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
    }
    self.word = textView.text;
}


#pragma mark - getter and setter
#pragma mark -
//- (UITextField *)inputTextField {
//    if (!_inputTextField) {
//        _inputTextField = [UITextField new];
//        _inputTextField.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
//        _inputTextField.placeholder = @"输入您想翻译的词语或句子";
//        _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
//        
//        
//        [_inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    }
//    
//    return _inputTextField;
//}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = UIButton.builder()
        .title(@"翻译")
        .titleColor([UIColor whiteColor])
        .backgroundColor([UIColor colorWithHexString:@"0x1989F5"])
        .build();
        
        self.searchButton.layer.cornerRadius = 8;
        self.searchButton.layer.masksToBounds = YES;
        
        [self.searchButton sf_addHandler:^(id weakSender) {
            
            
            YHSearchWordApi *api = [[YHSearchWordApi alloc] initWithWord:self.word];
            api.delegate = self;
            
            [api start];
            
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (UILabel *)ChineseTitleLabel {
    if (!_ChineseTitleLabel) {
        _ChineseTitleLabel = UILabel.builder()
        .text(@"查询结果：")
        .textColor([UIColor whiteColor])
        .textAlignment(NSTextAlignmentLeft)
        .font([UIFont systemFontOfSize:35])
        .backgroundColor([UIColor clearColor])
        .build();
    }
    return _ChineseTitleLabel;
}

- (UILabel *)ChineseLabel {
    if (!_ChineseLabel) {
        _ChineseLabel = UILabel.builder()
        .text(@"TTTTT")
        .textColor([UIColor whiteColor])
        .textAlignment(NSTextAlignmentLeft)
        .font([UIFont systemFontOfSize:20])
        .backgroundColor([UIColor clearColor])
        .numberOfLines(4)
        .build();
        
    }
    return _ChineseLabel;
}

- (UITextView *)engTextView {
    if (!_engTextView) {
        _engTextView = [[UITextView alloc] init];
        _engTextView.textContainerInset = UIEdgeInsetsMake(12, 12, 12, 12);
        _engTextView.backgroundColor = [UIColor colorWithHexString:@"0x292D36"];
        _engTextView.font = [UIFont systemFontOfSize:17];
        _engTextView.textColor = [UIColor whiteColor];
        _engTextView.placeholder = @"请输入您想要翻译的词语或句子";
        _engTextView.placeholderColor = [UIColor colorWithHexString:@"0xCCCCCC"];
        _engTextView.sf_maxLength = 100;
        _engTextView.delegate = self;
        
        _engTextView.layer.cornerRadius = 10;
        _engTextView.layer.masksToBounds = YES;
        _engTextView.layer.borderWidth = 1;
        _engTextView.layer.borderColor = [UIColor colorWithHexString:@"0x979797"].CGColor;
    }
    return _engTextView;
}

- (UITextView *)zhTextView {
    if (!_zhTextView) {
        _zhTextView = [[UITextView alloc] init];
        _zhTextView.textContainerInset = UIEdgeInsetsMake(12, 12, 12, 12);
        _zhTextView.backgroundColor = [UIColor colorWithHexString:@"0x292D36"];
        _zhTextView.font = [UIFont systemFontOfSize:17];
        _zhTextView.textColor = [UIColor whiteColor];
        _zhTextView.placeholder = @"翻译结果";
        _zhTextView.placeholderColor = [UIColor colorWithHexString:@"0xCCCCCC"];
        
//        _zhTextView.sf_maxLength = 100;
//        _zhTextView.delegate = self;
        
        _zhTextView.layer.cornerRadius = 10;
        _zhTextView.layer.masksToBounds = YES;
        _zhTextView.layer.borderWidth = 1;
        _zhTextView.layer.borderColor = [UIColor colorWithHexString:@"0x979797"].CGColor;
        _zhTextView.userInteractionEnabled = NO;
    }
    return _zhTextView;
}
@end
