//
//  UIButton+SFEdgeInsets.h
//  CodeStudy
//
//  Created by zhang on 7/12/16.
//  Copyright © 2016 zhangliuliu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger, SFImagePosition){
    SFImagePositionLeft = 0,
    SFImagePositionRight,
    SFImagePositionTop,
    SFImagePositionBottom
};

@interface UIButton (SFEdgeInsets)

- (void)setImagePosition:(SFImagePosition)imagePosition spacing:(CGFloat)spacing;

- (void)adjustImagePosition:(SFImagePosition)imagePosition spacing:(CGFloat)spacing;

@end
