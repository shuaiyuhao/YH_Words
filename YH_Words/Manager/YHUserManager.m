//
//  YHUserManager.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/5/5.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHUserManager.h"
#import <YYCache.h>
#import "YHUserModel.h"

static NSString * const kUserID = @"kUserID";
static NSString * const kPhone = @"kPhone";
static NSString * const kAvatar = @"kAvatar";
static NSString * const kUsername = @"kUsername";
static NSString * const kLevel = @"kLevel";

@interface YHUserManager ()

@property (nonatomic,strong) YYCache *myCache;

@property (nonatomic,assign) BOOL hasLogin;

@end


@implementation YHUserManager
+ (instancetype)sharedManager {
    static YHUserManager *manager = nil;
    static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           manager = [[YHUserManager alloc] init];
       });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _myCache = [YYCache cacheWithName:@"com.vwidea.yhwords.usercache"];
    }
    return self;
}

- (void)updateUserInfo:(id)userInfo {
    if (![userInfo isKindOfClass:[YHUserModel class]]) {
        NSLog(@"------- updateUserInfo failed");
        return;
    }
    
    YHUserModel *model = userInfo;
    self.avatar = model.avatar;
    self.phone = model.phone;
    self.userName = model.userName;
    self.level = model.level;
    self.userId = model.userId;
}

- (void)clearUserInfo {
    [self.myCache removeObjectForKey:kUserID];
    [self.myCache removeObjectForKey:kAvatar];
    [self.myCache removeObjectForKey:kLevel];
}

- (BOOL)hasLogin {
    NSNumber *obj = (NSNumber *)[self.myCache objectForKey:kUserID];
    return [obj integerValue] > 0;
}

- (void)setUserId:(NSInteger)userId {
    [self.myCache setObject:@(userId) forKey:kUserID];
}

- (NSInteger)userId {
    NSNumber *obj = (NSNumber *)[self.myCache objectForKey:kUserID];
    
    return [obj integerValue];
}

- (void)setPhone:(NSString *)phone {
    [self.myCache setObject:phone forKey:kPhone];
}

- (NSString *)phone {
    return (NSString *)[self.myCache objectForKey:kPhone];
}

- (void)setUserName:(NSString *)userName {
    [self.myCache setObject:userName forKey:kUsername];
}

- (NSString *)userName {
    return (NSString *)[self.myCache objectForKey:kUsername];
}

- (void)setAvatar:(NSString *)avatar {
    [self.myCache setObject:avatar forKey:kAvatar];
}

-(NSString *)avatar {
    return (NSString *)[self.myCache objectForKey:kAvatar];
}

- (void)setLevel:(NSInteger)level {
    [self.myCache setObject:@(level) forKey:kLevel];
}

- (NSInteger)level {
    
    NSNumber *obj = (NSNumber *)[self.myCache objectForKey:kLevel];
    return [obj integerValue];
}




@end
