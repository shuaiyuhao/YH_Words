//
//  UIImageView+SFBuilder.h
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import <UIKit/UIKit.h>
#import "SFImageViewBuilder.h"

@interface UIImageView (SFBuilder)

+ (SFImageViewBuilder * (^)(void))builder;

@end
