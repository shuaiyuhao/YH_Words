//
//  NSDictionary+SFAdd.h
//  SFCategories
//
//  Created by zhang on 2017/2/9.
//  Copyright © 2017年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SFAdd)

/**
 字典转json字符串

 @param dic 字典数据
 @return json 字符串
 */
+ (NSString *)dictionaryToJsonString:(NSDictionary *)dic;

/**
 json字符串转字典

 @param jsonString json字符串
 @return 字典数据
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
