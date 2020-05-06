//
//  YTKBaseRequest+SFHUDAccessory.h
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/9.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "YTKBaseRequest.h"
#import "SFHUDRequestAccessory.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTKBaseRequest (SFHUDAccessory)

@property (nonatomic,assign) SFHUDType hudType;
@property (nonatomic,strong) NSString *text;

@end

NS_ASSUME_NONNULL_END
