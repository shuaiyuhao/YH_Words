//
//  UILabel+SFBuilder.h
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import <UIKit/UIKit.h>
#import "SFLabelBuilder.h"

@interface UILabel (SFBuilder)

+ (SFLabelBuilder * (^)(void))builder;

@end
