//
//  NSString+SFDiskSpace.m
//  DianMingShi
//
//  Created by zhang on 2017/5/2.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import "NSString+SFDiskSpace.h"

#define MB (1024 * 1024)
#define GB (MB * 1024)

@implementation NSString (SFDiskSpace)

+ (NSString *)memoryFormatter:(long long)diskSpace {
    NSString *formatted;
    double bytes = 1.0 * diskSpace;
    double megabytes = bytes / MB;
    double gigabytes = bytes / GB;
    if (gigabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.1fG", gigabytes];
    else if (megabytes >= 0.0)
        formatted = [NSString stringWithFormat:@"%.1fM", megabytes];
    else
        formatted = [NSString stringWithFormat:@"%.1fb", bytes];
    
    return formatted;
}

@end
