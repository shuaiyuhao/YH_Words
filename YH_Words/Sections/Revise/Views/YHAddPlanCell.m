//
//  YHAddPlanCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/10.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHAddPlanCell.h"
#import <Masonry.h>
#import "UILabel+SFBuilder.h"
#import "UIColor+SFAdd.h"
#import "UITextField+SFBuilder.h"

@interface YHAddPlanCell ()

@property (nonatomic,strong) UITextField *planTextField;

@end

@implementation YHAddPlanCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithHexString:@"0x171c24"]];
        
        [self.contentView addSubview:self.planTextField];
        
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews {
    [self.planTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 45));
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
}

+ (CGFloat)cellHeight {
    return 50.f;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

- (void)textDidChange:(UITextField *)sender {
    if (self.textChangeBlock) {
        self.textChangeBlock(sender.text);
    }
}


#pragma mark - getter and setter
#pragma mark -
- (UITextField *)planTextField {
    
    if (!_planTextField) {
        _planTextField = UITextField.builder()
        .placeholder(@"请输入您的计划")
        .backgroundColor([UIColor clearColor])
        .textColor([UIColor whiteColor])
        .build();
        
        [self.planTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _planTextField;
}

@end
