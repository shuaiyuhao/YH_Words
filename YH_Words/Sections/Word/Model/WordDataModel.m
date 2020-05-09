//
//  WordDataModel.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/22.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "WordDataModel.h"

@implementation WordDataModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        _word = dic[@"word"];
        _chinese = dic[@"chinese"];
        _example = dic[@"example"];
        _phonetic = dic[@"phonetic"];
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"wordId":@[@"wordsId",@"id"],
        @"word":@"word",
        @"phonetic":@"phoneticSymbol",
        @"chinese":@"explanation",
        @"example":@"illustrativeSentence1"
    };
}
@end
