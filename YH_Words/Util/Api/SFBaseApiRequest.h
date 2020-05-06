//
//  SFBaseApiRequest.h
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/9.
//Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "YTKRequest.h"
#import "YTKBaseRequest+SFHUDAccessory.h"
#import "YTKChainRequest+SFHUDAccessory.h"
#import "YTKBatchRequest+SFHUDAccessory.h"
#import "SFReformerProtocol.h"
#import "AppConstant.h"
#import "YHUserManager.h"

@protocol SFReformerProtocol;

@interface SFBaseApiRequest : YTKRequest

@property (nonatomic,strong,readonly) NSString *errorMsg;
@property (nonatomic,assign,readonly) NSInteger errorCode;
@property (nonatomic,assign,readonly) BOOL success;

- (id)fetchDataWithReformer:(id <SFReformerProtocol>)reformer;

- (id)fetchRawData;

@end
