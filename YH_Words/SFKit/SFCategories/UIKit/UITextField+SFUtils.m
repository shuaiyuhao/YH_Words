//
//  UITextField+SFUtils.m
//  DianMingShi
//
//  Created by zhang on 2017/3/29.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "UITextField+SFUtils.h"
#import "UIImageView+SFFly.h"
#import "Masonry.h"
//#import "AppMacros.h"

@implementation UITextField (SFUtils)

- (void)sf_setLeftImage:(UIImage *)image{
    CGSize size = CGSizeMake(50, 40);
    UIView *leftView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,size}];
    UIImageView *imageView = [UIImageView imageViewWithImage:image];
    [leftView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(leftView);
    }];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)sf_setLeftPadding:(CGFloat)padding{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, 5)];
    self.leftView = paddingView;
    self.backgroundColor = self.backgroundColor;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
