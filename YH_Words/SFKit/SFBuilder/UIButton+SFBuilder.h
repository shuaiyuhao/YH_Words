//
//  UIButton+SFBuilder.h
//  SFKit_Example
//
//  Created by liuliu zhang on 2018/6/6.
//  Copyright © 2018年 zll19911011@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFButtonBuilder.h"

@interface UIButton (SFBuilder)

+ (SFButtonBuilder * (^)(void))builder;

@end
