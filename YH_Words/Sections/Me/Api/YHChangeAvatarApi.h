//
//  YHChangeAvatarApi.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/9.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "SFBaseApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHChangeAvatarApi : SFBaseApiRequest

- (instancetype)initWithUserId:(NSInteger)userId avatar:(NSString *)avatar token:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
