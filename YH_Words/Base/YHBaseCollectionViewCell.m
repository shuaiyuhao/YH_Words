//
//  YHBaseCollectionViewCell.m
//  YH_Words
//
//  Created by Yuhao Shuai on 2020/4/21.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHBaseCollectionViewCell.h"

@implementation YHBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+ (nonnull NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}
@end
