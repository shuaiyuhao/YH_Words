//
//  YHCollectWordApi.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/8.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "SFBaseApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHCollectWordApi : SFBaseApiRequest

- (instancetype)initWithToken:(NSString *)token userId:(NSInteger)userId wordId:(NSInteger)wordId;

@end

NS_ASSUME_NONNULL_END
