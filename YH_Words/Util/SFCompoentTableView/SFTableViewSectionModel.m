//
//  SFTableViewSectionModel.m
//  Subway
//
//  Created by liuliu zhang on 2017/12/10.
//Copyright © 2017年 SamllFire. All rights reserved.
//

#import "SFTableViewSectionModel.h"

@implementation SFTableViewSectionModel

- (instancetype)initWithItems:(NSArray<SFTableViewItemModel *> *)items headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight{
    self = [super init];
    if (!self) {
        return nil;
    }
    _items = items;
    _headerHeight = headerHeight;
    _footerHeight = footerHeight;
    return self;
}

@end
