//
//  SFTabelViewDataSource.h
//  Subway
//
//  Created by liuliu zhang on 2017/12/10.
//Copyright © 2017年 SamllFire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SFTableViewSectionModel.h"
#import "SFBaseTableViewModel.h"

@protocol SFTableViewComponentDelegate<NSObject>

- (void)configWithData:(id)data;

+ (CGFloat)cellHeight:(id)data;

@optional
- (void)setCellIndexPath:(NSIndexPath *)indexPath;

@end

@protocol SFTableViewDataSourceDelegate <NSObject>

- (void)tableViewWithData:(id)data didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SFTableViewDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<SFTableViewSectionModel *> *) sections;

- (instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<SFTableViewSectionModel *> *) sections delegate:(id<SFTableViewDataSourceDelegate>)delegate;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,weak) id<SFTableViewDataSourceDelegate> delegate;

@end
