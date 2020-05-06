//
//  SFRefreshApiRequest.m
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/19.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "SFRefreshApiRequest.h"

@interface SFRefreshApiRequest ()

@end

@implementation SFRefreshApiRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _offset = 0;
    }
    return self;
}

- (void)loadNewData {
    self.offset = 0;
    [self start];
}

- (void)loadNext:(NSInteger)offset {
    self.offset = offset;
    [self start];
}

@end
