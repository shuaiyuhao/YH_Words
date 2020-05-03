//
//  SFTableViewItemModel.m
//  Subway
//
//  Created by liuliu zhang on 2017/12/10.
//Copyright © 2017年 SamllFire. All rights reserved.
//

#import "SFTableViewItemModel.h"

@implementation SFTableViewItemModel

- (instancetype)initWithData:(id)data className:(NSString *)className{
    self = [super init];
    if (!self) {
        return nil;
    }
    _data = data;
    _className = className;
    return self;
}
@end
