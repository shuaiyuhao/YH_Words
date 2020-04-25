//
//  YHSearchWordController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/23.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHSearchWordController.h"
#import "YHSearchWordApi.h"

@interface YHSearchWordController ()<YTKRequestDelegate, UITextFieldDelegate>

@property (nonatomic,strong) UITextField *inputTextField;

@property (nonatomic,strong) UIButton *searchButton;

@property (nonatomic,strong) NSString *word;

@property (nonatomic,strong) UILabel *ChineseTitleLabel;
@property (nonatomic,strong) UILabel *ChineseLabel;
@property (nonatomic,strong) NSString *translate;
//@property (nonatomic,strong) 

@end

@implementation YHSearchWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
    [self.view addSubview:self.inputTextField];
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.ChineseTitleLabel];
    [self.view addSubview:self.ChineseLabel];
    
    [self layoutPageViews];
    
}

- (void)layoutPageViews {
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(260, 40));
        make.left.equalTo(self.view).offset(30);
        make.top.equalTo(self.view).offset(30);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.equalTo(self.inputTextField);
        make.left.equalTo(self.inputTextField.mas_right).offset(25);
    }];
    
    [self.ChineseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 60));
        make.top.equalTo(self.inputTextField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(30);
    }];
    
    [self.ChineseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 70));
        make.top.equalTo(self.ChineseTitleLabel.mas_bottom).offset(25);
        make.left.equalTo(self.view).offset(20);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.inputTextField resignFirstResponder];
}

#pragma mark - YTKRequestDelegate
#pragma mark -
- (void)requestFinished:(__kindof YTKBaseRequest *)request {
    if ([request.responseObject isKindOfClass:[NSDictionary class]]) {
        id data = request.responseObject;
        NSLog(@"%@", data);
        
        self.translate = data[@"trans_result"][0][@"dst"];
    }
    
    self.ChineseLabel.text = self.translate;

}

#pragma mark - UITextFieldDelegate
#pragma amrk -
- (void)textFieldDidChange:(UITextField *)sender {
    self.word = sender.text;
    NSLog(@"%@",sender.text);
}


#pragma mark - getter and setter
#pragma mark -
- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [UITextField new];
        _inputTextField.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
        _inputTextField.placeholder = @"输入您想翻译的词语或句子";
        _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        
        [_inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _inputTextField;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = UIButton.builder()
        .image([UIImage imageNamed:@"ic_search"])
        .build();
        
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

@end
