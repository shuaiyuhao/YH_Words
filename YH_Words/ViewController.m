//
//  ViewController.m
//  YH_Words
//
//  Created by Yuhao on 2020/1/12.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic,strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label];
    
    
    [self layoutPageViews];
}

- (void)layoutPageViews {
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.text = @"test page";
        _label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    }
    return _label;
}
@end
