//
//  SFNetworkActivityConsoleLogger.h
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/11/1.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworkActivityConsoleLogger.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFNetworkActivityConsoleLogger : NSObject <AFNetworkActivityLoggerProtocol>

@property (nonatomic, strong) NSPredicate *filterPredicate;
@property (nonatomic, assign) AFHTTPRequestLoggerLevel level;

@end

NS_ASSUME_NONNULL_END
