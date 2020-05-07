//
//  YHStudyWordsListApi.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/6.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "SFBaseApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHStudyWordsListApi : SFBaseApiRequest

- (instancetype)initWithPage:(NSInteger)page row:(NSInteger)row userId:(NSInteger)userId;

@end

NS_ASSUME_NONNULL_END
