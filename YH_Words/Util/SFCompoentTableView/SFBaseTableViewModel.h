//
//  SFBaseTableViewModel.h
//  zhichaoyijia-client
//
//  Created by xiaohuodui-2 on 2019/11/4.
//  Copyright © 2019 xiaohuodui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SFBaseTableViewModel : NSObject

@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) id data;
@property (nonatomic,strong) id block;
@property (nonatomic,strong) id twoBlock;

@end

NS_ASSUME_NONNULL_END
