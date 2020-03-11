//
//  SFImageViewBuilder.m
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import "SFImageViewBuilder.h"

@interface SFImageViewBuilder ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation SFImageViewBuilder

- (instancetype)init{
    self = [super init];
    if (self) {
        self.imageView = [UIImageView new];
        self.imageView.clipsToBounds = YES;
    }
    return self;
}

- (SFImageViewBuilder *(^)(UIImage *))image{
    return ^SFImageViewBuilder * (UIImage *image){
        self.imageView.image = image;
        return self;
    };
}

- (SFImageViewBuilder *(^)(UIImage *))highlightedImage{
    return ^SFImageViewBuilder * (UIImage *highlightedImage){
        self.imageView.highlightedImage = highlightedImage;
        return self;
    };
}

- (SFImageViewBuilder *(^)(CGFloat))cornerRadius{
    return ^SFImageViewBuilder * (CGFloat cornerRadius){
        self.imageView.layer.cornerRadius = cornerRadius;
        self.imageView.layer.masksToBounds = YES;
        return self;
    };
}

- (SFImageViewBuilder *(^)(UIColor *))backgroundColor{
    return ^SFImageViewBuilder * (UIColor *backgroundColor){
        self.imageView.backgroundColor = backgroundColor;
        return self;
    };
}

- (SFImageViewBuilder *(^)(UIViewContentMode))contentMode{
    return ^SFImageViewBuilder * (UIViewContentMode contentMode){
        self.imageView.contentMode = contentMode;
        return self;
    };
}

- (UIImageView *(^)(void))build{
    return ^UIImageView * (void){
        return self.imageView;
    };
}

@end
