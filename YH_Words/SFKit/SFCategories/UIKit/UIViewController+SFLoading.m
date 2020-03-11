//
//  UIViewController+SFLoading.m
//  Barbecue
//
//  Created by zhang on 2017/6/29.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "UIViewController+SFLoading.h"
#import <objc/runtime.h>
#import "Masonry.h"

#pragma mark - SFLoadingView
#pragma mark -

@interface SFLoadingView : UIView

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation SFLoadingView

- (instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.activityIndicatorView];
        [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

- (void)didMoveToSuperview{
    self.backgroundColor = self.superview.backgroundColor;
    [self.activityIndicatorView startAnimating];
}

#pragma mark - getter and setter
#pragma mark -
- (UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityIndicatorView;
}

@end

#pragma mark - UIViewController (SFLoading)
#pragma mark -

//static char const * const kLoadingView = "loadingView";

@interface UIViewController ()

@property (nonatomic,strong) SFLoadingView *loadingView;
@property (nonatomic,strong) UIView *customView;

@end

@implementation UIViewController (SFLoading)

- (void)startLoading {
    [self.loadingView removeFromSuperview];
    [self.view addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)startLoadingWithCustomView:(UIView *)customView {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.customView) {
            [self.customView removeFromSuperview];
            self.customView = nil;
        }
        self.customView = customView;
        [self.view addSubview:self.customView];
        
        if ([self.view isKindOfClass:[UITableView class]]) {
            self.customView.frame = self.view.bounds;
            return;
        }
        [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    });
}

- (void)stopLoading {
    [UIView animateWithDuration:0.2 animations:^{
        if (self.customView) {
            self.customView.alpha = 0;
        }else {
            self.loadingView.alpha = 0;
        }
    } completion:^(BOOL finished) {
        if (self.customView) {
            [self.customView removeFromSuperview];
        }else {
            [self.loadingView removeFromSuperview];
        }
    }];
}

#pragma mark - getter and setter
#pragma mark -
- (SFLoadingView *)loadingView{
    SFLoadingView *view = objc_getAssociatedObject(self, @selector(loadingView));
    if (!view) {
        view = [SFLoadingView new];
        [self setLoadingView:view];
    }
    return view;
}

- (void)setLoadingView:(SFLoadingView *)loadingView{
    objc_setAssociatedObject(self, @selector(loadingView), loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIView *)customView{
    UIView *view = objc_getAssociatedObject(self, @selector(customView));
    return view;
}

- (void)setCustomView:(UIView *)customView {
    objc_setAssociatedObject(self, @selector(customView), customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
