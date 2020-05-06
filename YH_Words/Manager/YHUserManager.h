//
//  YHUserManager.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/5.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHUserManager : NSObject

@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,assign) NSInteger level;


+ (instancetype)sharedManager;

- (void)updateUserInfo:(id)userInfo;
- (void)clearUserInfo;


@end

NS_ASSUME_NONNULL_END
