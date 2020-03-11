//
//  NSDate+SFAdd.h
//  SFCategories
//
//  Created by zhang on 2017/8/14.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const SFDateFormatOne;
extern NSString * const SFDateFormatTwo;
extern NSString * const SFDateFormat;

@interface NSDate (SFAdd)

/**
 获取离当前时间过去了多了

 @param timeInterval timeInterval
 @return 几秒钟前、几分钟前、几小时前、几天前、几月前、几年前
 */
+ (NSString *)timeInfoSinceNow:(NSTimeInterval)timeInterval;

/**
 获取星期几的描述，例：周一、周日

 @return 周几
 */
- (NSString*)weekdayString;

@end
