//
//  YHUserModel.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/5.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHUserModel : NSObject

@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,copy) NSString *token;
@end

NS_ASSUME_NONNULL_END
