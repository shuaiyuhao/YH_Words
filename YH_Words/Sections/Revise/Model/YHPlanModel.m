//
//  YHPlanModel.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/5.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHPlanModel.h"

@implementation YHPlanModel

- (instancetype)initWithString:(NSString *)str {
    self = [super init];
    if (self) {
        _plan = str;
        _isDone = false;
    }
    return self;
}

@end
