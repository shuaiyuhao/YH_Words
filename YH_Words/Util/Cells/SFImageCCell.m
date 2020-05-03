//
//  SFImageCCell.m
//  zhuling
//
//  Created by xiaohuodui-2 on 2019/7/19.
//  Copyright © 2019年 xiaohuodui-2. All rights reserved.
//

#import "SFImageCCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "UIButton+SFBuilder.h"
#import "UILabel+SFBuilder.h"
#import "UIControl+SFActionBlock.h"
#import "UILabel+SFFly.h"
#import "AppMacros.h"
#import "UIColor+SFUIConfig.h"

@interface SFImageCCell ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *closeButton;

@end

@implementation SFImageCCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.closeButton];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(56, 56));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.centerY.equalTo(self.imageView.mas_top);
        make.centerX.equalTo(self.imageView.mas_right);
    }];
}

- (void)configWithData:(id)data{
    if(data && [data isKindOfClass:[UIImage class]]){
        self.imageView.image = (UIImage *)data;
        self.closeButton.hidden = NO;
    }else{
       self.imageView.image = [UIImage imageNamed:@"ic_image_add"];
        self.closeButton.hidden = YES;
    }
}

+ (CGSize)cellSize{
    CGFloat width = floorf((kScreenWidth - 12 * 3) / 2);
    return CGSizeMake(56+8,56+16);
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

#pragma mark - getter and setter
#pragma mark -
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
        _imageView.image = [UIImage imageNamed:@"ic_image_add"];
    }
    return _imageView;
}

- (UIButton *)closeButton{
    if(!_closeButton){
        _closeButton = UIButton.builder()
        .title(@"X")
        .backgroundColor([UIColor sf_appRedColor])
        .font([UIFont systemFontOfSize:12])
        .image([UIImage imageNamed:@""])
        .cornerRadius(8)
        .build();
        WeakSelf;
        [_closeButton sf_addHandler:^(id weakSender) {
            if(weakSelf.deleteBlock){
                weakSelf.deleteBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

@end
