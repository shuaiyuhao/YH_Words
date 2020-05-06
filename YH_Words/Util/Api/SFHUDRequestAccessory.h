//
//  SFHUDRequestAccessory.h
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/9.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKBaseRequest.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SFHUDType){
    SFHUDTypeProgressAlert = 0,
    SFHUDTypeLoadingView
};

@interface SFHUDRequestAccessory : NSObject <YTKRequestAccessory>

@property (nonatomic,assign) SFHUDType hudType;
@property (nonatomic,strong) NSString *text;

+ (instancetype)accessoryWithHUDType:(SFHUDType)hudType;

+ (instancetype)accessoryWithHUDType:(SFHUDType)hudType text:(NSString * _Nullable)text;

@end

NS_ASSUME_NONNULL_END
