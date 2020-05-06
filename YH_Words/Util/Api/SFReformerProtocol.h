//
//  SFReformerProtocol.h
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/10.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFBaseApiRequest.h"
@class SFBaseApiRequest;

@protocol SFReformerProtocol <NSObject>

- (id)reformDataWithApiRequest:(SFBaseApiRequest *)api;

@end
