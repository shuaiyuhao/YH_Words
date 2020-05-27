//
//  YHPlanModel.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/5.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHPlanModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *plan;

@property (nonatomic,assign) BOOL isDone;

- (instancetype)initWithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
