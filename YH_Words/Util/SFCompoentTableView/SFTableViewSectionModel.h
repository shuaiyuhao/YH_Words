//
//  SFTableViewSectionModel.h
//  Subway
//
//  Created by liuliu zhang on 2017/12/10.
//Copyright © 2017年 SamllFire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SFTableViewItemModel.h"

@interface SFTableViewSectionModel : NSObject

@property (nonatomic,strong) NSString *headerTitle;
@property (nonatomic,strong) NSString *footerTitle;

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,assign) CGFloat headerHeight;
@property (nonatomic,assign) CGFloat footerHeight;

@property (nonatomic,strong) NSArray<SFTableViewItemModel *> *items;

- (instancetype)initWithItems:(NSArray<SFTableViewItemModel *> *)items headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight;

@end
