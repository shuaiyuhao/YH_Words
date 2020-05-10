//
//  YHMemoryLineApi.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/7.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "SFBaseApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHRememberLineApi : SFBaseApiRequest

- (instancetype)initWithUserId:(NSInteger)userId token:(NSString *)token type:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
