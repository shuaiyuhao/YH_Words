//
//  UITextField+SFBuilder.h
//  SFKit
//
//  Created by liuliu zhang on 2018/6/6.
//

#import <UIKit/UIKit.h>
#import "SFTextFieldBuilder.h"

@interface UITextField (SFBuilder)

+ (SFTextFieldBuilder * (^)(void))builder;

@end
