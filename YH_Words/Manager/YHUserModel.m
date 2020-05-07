//
//  YHUserModel.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/5.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHUserModel.h"

@implementation YHUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"userId":@[@"id",@"usrId",@"userID"],
        @"avatar":@"headSculpture"
    };
}

@end
