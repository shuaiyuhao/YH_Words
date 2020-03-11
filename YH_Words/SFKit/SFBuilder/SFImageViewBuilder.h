//
//  SFImageViewBuilder.h
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFImageViewBuilder : NSObject

- (SFImageViewBuilder *(^)(UIImage *))image;

- (SFImageViewBuilder *(^)(UIImage *))highlightedImage;

- (SFImageViewBuilder *(^)(CGFloat))cornerRadius;

- (SFImageViewBuilder *(^)(UIColor *))backgroundColor;

- (SFImageViewBuilder *(^)(UIViewContentMode))contentMode;

- (UIImageView *(^) (void))build;

@end
