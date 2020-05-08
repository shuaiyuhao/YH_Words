//
//  YHUploadImageApi.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/7.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "SFBaseApiRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHUploadImageApi : SFBaseApiRequest

- (instancetype)initWithName:(NSString *)fileName data:(NSString *)imgData;

@end

NS_ASSUME_NONNULL_END
