//
//  YHMeCollectWordsListApi.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/8.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "SFBaseApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHMeCollectWordsListApi : SFBaseApiRequest

- (instancetype)initWithPage:(NSInteger)page row:(NSInteger)row userId:(NSInteger)userId token:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
