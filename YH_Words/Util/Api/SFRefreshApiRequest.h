//
//  SFRefreshApiRequest.h
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/19.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "SFBaseApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFRefreshApiRequest : SFBaseApiRequest

@property (nonatomic,assign) NSInteger offset;

- (void)loadNewData;

- (void)loadNext:(NSInteger)offset;

@end

NS_ASSUME_NONNULL_END
