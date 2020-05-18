//
//  YHProblemReportController.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/16.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHProblemReportController.h"
#import "SFTitleFieldCell.h"
#import "SFHUD.h"
#import "UITextView+SFPlaceholder.h"
#import "UITextView+SFInputLimit.h"

@interface YHProblemReportController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) UIButton *commitButton;
@property (nonatomic,strong) UITextView *problemTextView;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic,strong) UIButton *cleanButton;

@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *content;

@end

@implementation YHProblemReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"问题反馈";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"0x171C24"]];
    
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.commitButton];
    [self.view addSubview:self.problemTextView];
    [self.view addSubview:self.cleanButton];
    [self.view addSubview:self.placeHolderLabel];
    
    [self layoutPageViews];
}

- (void)layoutPageViews {
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-35);
        make.centerX.equalTo(self.view);
    }];
    
    [self.problemTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 350));
        make.top.equalTo(self.myTableView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.bottom.equalTo(self.problemTextView.mas_bottom).offset(-10);
        make.right.equalTo(self.cleanButton.mas_left).offset(-10);
    }];
    
    [self.cleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.bottom.equalTo(self.problemTextView.mas_bottom).offset(-10);
        make.right.equalTo(self.problemTextView.mas_right).offset(-5);
        
    }];
}

#pragma mark - UITextViewDelegate
#pragma mark -

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    NSString *str = [NSString stringWithFormat:@"%@%@",textView.text, text];
//
//    if (str.length > 800) {
//        textView.text = [textView.text substringToIndex:800];
//        return NO;
//    }
//    return YES;
//
//}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 800) {
        textView.text = [textView.text substringToIndex:800];
    }
    self.content = textView.text;
    self.placeHolderLabel.text = [NSString stringWithFormat:@"%lu/%d", (unsigned long)[textView.text length], 800];
}

#pragma mark - UITableViewDelegate
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SFTitleFieldCell cellHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - UITableViewDataSource
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFTitleFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[SFTitleFieldCell cellIdentifier] forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        [cell setTitle:@"昵称" value:@"" placeholder:@"请输入您的昵称"];
        [cell setValueTextFieldLeftPadding:30];
        
        WeakSelf;
        [cell setStringBlock:^(NSString *index) {
            weakSelf.nickname = index;
        }];
        return cell;
    }
    
    [cell setTitle:@"电话" value:@"" placeholder:@"请输入您的电话"];
     [cell setValueTextFieldLeftPadding:30];
    cell.keyboardType = UIKeyboardTypePhonePad;
    cell.limit = 11;
    WeakSelf;
    [cell setStringBlock:^(NSString *index) {
        weakSelf.phone = index;
    }];
    
    return cell;
}

#pragma mark - getter and setter
#pragma mark -
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100) style:UITableViewStyleGrouped];
            [tableView registerClass:[SFTitleFieldCell class] forCellReuseIdentifier:[SFTitleFieldCell cellIdentifier]];
            
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.scrollEnabled = NO;
            tableView.backgroundColor = [UIColor clearColor];
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            tableView.showsVerticalScrollIndicator = NO;
        
            tableView;
        });
    }
    
    return _myTableView;
}

- (UIButton *)commitButton {
    if (!_commitButton) {
        _commitButton = [self buttonWithSize:CGSizeMake(kScreenWidth - 20, 44)];
        [self.commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [self toCornradius:22 with:_commitButton];
        
        WeakSelf;
        [_commitButton sf_addHandler:^(id weakSender) {
            if(!weakSelf.nickname){
                [SFHUD showToast:@"请输入昵称"];
                return ;
            }
            if(!weakSelf.phone){
                [SFHUD showToast:@"请输入手机号"];
                return ;
            }
            if(!weakSelf.content){
                [SFHUD showToast:@"请输入反馈内容"];
                return ;
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = UILabel.builder()
        .text(@"0/800")
        .textColor([UIColor grayColor])
        .font([UIFont systemFontOfSize:14])
        .textAlignment(NSTextAlignmentCenter)
        .build();

        _placeHolderLabel.numberOfLines = 0;
    }
    
    return _placeHolderLabel;
}

- (UITextView *)problemTextView {
    if (!_problemTextView) {
        _problemTextView = [[UITextView alloc] init];
        _problemTextView.textContainerInset = UIEdgeInsetsMake(12, 12, 12, 12);
        _problemTextView.backgroundColor = [UIColor colorWithHexString:@"0x171c24"];
        _problemTextView.font = [UIFont systemFontOfSize:14];
        _problemTextView.textColor = [UIColor whiteColor];
        _problemTextView.placeholder = @"把你想说的话里在这里就好......";
        _problemTextView.sf_maxLength = 800;
        _problemTextView.delegate = self;
        
    }
    
    return _problemTextView;
}

- (UIButton *)cleanButton {
    if (!_cleanButton) {
        _cleanButton = UIButton.builder()
        .title(@"清除")
        .titleColor([UIColor whiteColor])
        .font([UIFont systemFontOfSize:14])
        .build();
        
        [self.cleanButton addTarget:self action:@selector(cleanButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cleanButton;
}
@end
