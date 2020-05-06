//
//  YHRegisterApi.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/5.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YTKBaseRequest.h"
#import "SFBaseApiRequest.h"


NS_ASSUME_NONNULL_BEGIN

@interface YHRegisterApi : SFBaseApiRequest

- (instancetype)initWithPhone:(NSString *)phone username:(NSString *)userName passwd:(NSString *)passwd;

@end

NS_ASSUME_NONNULL_END
