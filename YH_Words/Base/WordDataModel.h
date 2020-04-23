//
//  WordDataModel.h
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/22.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WordDataModel : NSObject

@property (nonatomic,strong) NSString *word;
@property (nonatomic,strong) NSString *chinese;
@property (nonatomic,strong) NSString *phonetic;
@property (nonatomic,strong) NSString *example;


- (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
