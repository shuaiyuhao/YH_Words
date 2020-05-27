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

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.plan forKey:@"plan"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if (self = [super init]) {
        self.plan = [coder decodeObjectForKey:@"plan"];
    }
    return self;
}

@end
