//
//  YHTodayRememberListApi.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/9.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "SFBaseApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHTodayRememberListApi : SFBaseApiRequest

- (instancetype)initWithPage:(NSInteger)page row:(NSInteger)row type:(NSInteger)type userId:(NSInteger)userId token:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
