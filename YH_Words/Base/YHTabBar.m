//
//  YHTabBar.m
//  YH_Words
//
//  Created by Yuhao on 2020/3/27.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHTabBar.h"
#import "UIColor+SFAdd.h"

@interface YHTabBar ()

@property (nonatomic,strong) UIButton *centerTabBarButton;

@end

@implementation YHTabBar

#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight  ([UIScreen mainScreen].bounds.size.height)

#define iPhoneX ((ScreenHeight == 812.0 || ScreenHeight == 896.0) ? YES : NO)
#define kBottomSafeSpace (iPhoneX ? 34.0 : 0.0)

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    
    return self;
}


- (void)initView {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, -5, ScreenWidth, kBottomSafeSpace+49+10+40)];
    
    UIImage *image = [UIImage imageNamed:@"tabBar_background"];
    
    CGFloat top = 20;
    CGFloat left = 0;
    CGFloat bottom = 0;
    CGFloat right = 0;
    
    UIImage *bgImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:bgImage];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = backView.frame;
    [backView addSubview:imageView];
    
    [self insertSubview:backView atIndex:0];
    
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:[UIImage new]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blueColor] }
                                                   forState:UIControlStateNormal];

    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithHexString:@"0xD66563"] } forState:UIControlStateSelected];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = 50;
    self.centerTabBarButton.frame = CGRectMake((ScreenWidth-width)/2, -5, width, width);
    
    CGFloat tabBarButtonW = ScreenWidth / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *childView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([childView isKindOfClass:class]) {
            
            CGRect frame = CGRectMake(tabBarButtonIndex * tabBarButtonW, 0, tabBarButtonW, 49);
            childView.frame = frame;
            
            if (tabBarButtonIndex == 1) {
                tabBarButtonIndex ++;
            }
            tabBarButtonIndex++;
        }
    }
}

////处理超出区域点击无效的问题
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    if (self.hidden){
//        return [super hitTest:point withEvent:event];
//    }else {
//        //转换坐标
//        CGPoint tempPoint = [self.centerTabBarBtn convertPoint:point fromView:self];
//        //判断点击的点是否在按钮区域内
//        if (CGRectContainsPoint(self.centerTabBarBtn.bounds, tempPoint)){
//            //返回按钮
//            return self.centerTabBarBtn;
//        }else {
//            return [super hitTest:point withEvent:event];
//        }
//    }
//}

- (void)centerTabBarBtnEvent {
    
    NSLog(@"click event");
}

- (UIButton *)centerTabBarButton {
    
    if (_centerTabBarButton == nil) {
        _centerTabBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_centerTabBarButton];
        [_centerTabBarButton setImage:[UIImage imageNamed:@"icon5.png"] forState:UIControlStateNormal];
        _centerTabBarButton.adjustsImageWhenHighlighted = false;
        [_centerTabBarButton addTarget:self action:@selector(centerTabBarBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _centerTabBarButton;
}
@end
