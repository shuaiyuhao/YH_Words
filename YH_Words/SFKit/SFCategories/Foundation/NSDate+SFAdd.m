//
//  NSDate+SFAdd.m
//  SFCategories
//
//  Created by zhang on 2017/8/14.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "NSDate+SFAdd.h"
#import "NSDate+DateTools.h"

NSString * const SFDateFormatOne = @"yyyy-MM-dd HH:mm:ss";
NSString * const SFDateFormatTwo = @"yyyy-MM-dd HH:mm";

@implementation NSDate (SFAdd)

+ (NSString *)timeInfoSinceNow:(NSTimeInterval)timeInterval{
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    
    NSTimeInterval createTime = timeInterval/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    //小于1分钟
    if (time<60) {
        return [NSString stringWithFormat:@"%ld秒钟前",(long)time];
    }
    //小于1小时
    if (time < 3600) {
        NSInteger minutes = time/60;
        minutes = MAX(0, minutes);
        return [NSString stringWithFormat:@"%ld分钟前",(long)minutes];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",(long)days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld个月前",(long)months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",(long)years];
}

- (NSString*)weekdayString{
    NSArray *weekdays = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    //周日是“1”，周一是“2”
    return weekdays[self.weekday-1];
}

@end
