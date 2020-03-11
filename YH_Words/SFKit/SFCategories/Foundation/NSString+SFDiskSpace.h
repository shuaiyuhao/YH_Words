//
//  NSString+SFDiskSpace.h
//  DianMingShi
//
//  Created by zhang on 2017/5/2.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SFDiskSpace)

+ (NSString *)memoryFormatter:(long long)diskSpace;

@end
