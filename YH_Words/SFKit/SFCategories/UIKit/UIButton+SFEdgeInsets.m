//
//  UIButton+SFEdgeInsets.m
//  CodeStudy
//
//  Created by zhang on 7/12/16.
//  Copyright © 2016 zhangliuliu. All rights reserved.
//

#import "UIButton+SFEdgeInsets.h"

@implementation UIButton (SFEdgeInsets)

- (void)setImagePosition:(SFImagePosition)imagePosition spacing:(CGFloat)spacing{
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    switch (imagePosition) {
        case SFImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case SFImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case SFImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case SFImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
            
        default:
            break;
    }
}

- (void)adjustImagePosition:(SFImagePosition)imagePosition spacing:(CGFloat)spacing{
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    CGSize buttonSize = self.frame.size;
    CGSize labelSize = self.titleLabel.intrinsicContentSize;
    CGSize imageSize = self.imageView.image.size;
    CGFloat buttonWidth = buttonSize.width;
    CGFloat buttonHeight = buttonSize.height;
    CGFloat labelWidth = labelSize.width;
    CGFloat labelHeight = labelSize.height;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    switch (imagePosition) {
        case SFImagePositionLeft:{
            
        }
            break;
        case SFImagePositionRight:{
            
        }
            break;
        case SFImagePositionTop:{
            self.imageEdgeInsets = UIEdgeInsetsMake((buttonHeight - imageHeight - labelHeight - spacing) / 2, (buttonWidth - imageWidth) / 2, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake((buttonHeight - imageHeight - labelHeight - spacing) / 2 + spacing + imageHeight, (buttonWidth - labelWidth) / 2 - imageWidth, 0, 0);
            CGFloat tempHeight = MAX(buttonHeight, imageHeight + spacing + labelHeight);
            tempHeight = imageHeight + spacing + labelHeight - buttonHeight;
            self.contentEdgeInsets = UIEdgeInsetsMake(tempHeight/2, 0, tempHeight/2, 0);//autolayout 时会用到该属性
        }
            break;
        case SFImagePositionBottom:{
            
        }
            break;
        default:{
            
        }
            break;
    }
}

@end
