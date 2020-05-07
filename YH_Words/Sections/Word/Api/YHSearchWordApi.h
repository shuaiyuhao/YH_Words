//
//  YHSearchWordApi.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/24.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YTKBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHSearchWordApi : YTKBaseRequest

- (instancetype)initWithWord:(NSString *)word;

@end

NS_ASSUME_NONNULL_END
