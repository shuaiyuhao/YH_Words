//
//  SFTabelViewDataSource.m
//  Subway
//
//  Created by liuliu zhang on 2017/12/10.
//Copyright © 2017年 SamllFire. All rights reserved.
//

#import "SFTableViewDataSource.h"
#import "AppMacros.h"

@interface SFTableViewDataSource()

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSArray *sections;

@end

@implementation SFTableViewDataSource

- (instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<SFTableViewSectionModel *> *)sections{
    self = [super init];
    if (!self) {
        return nil;
    }
    _sections = sections;
    [sections enumerateObjectsUsingBlock:^(SFTableViewSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *className = @"";
        for (SFTableViewItemModel *itemModel in obj.items) {
            if (![className isEqualToString:itemModel.className]) {
                className = itemModel.className;
                NSString *filtePath = [NSString stringWithFormat:@"%@/%@.nib", [[NSBundle mainBundle]resourcePath],className];
                if ([[NSFileManager defaultManager]fileExistsAtPath:filtePath]) {
                    [tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
                }else{
                    [tableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
                }
            }
        }
    }];
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<SFTableViewSectionModel *> *) sections delegate:(id<SFTableViewDataSourceDelegate>)delegate{
    self = [self initWithTableView:tableView sections:sections];
    if (!self) {
        return nil;
    }
    self.delegate = delegate;
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    SFTableViewSectionModel *sectionModel = self.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

#pragma mark - UITableViewDataSource
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SFTableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    return sectionModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFTableViewItemModel *itemModel = [self itemAtIndexPath:indexPath];

    UITableViewCell<SFTableViewComponentDelegate> *cell = [tableView dequeueReusableCellWithIdentifier:itemModel.className forIndexPath:indexPath];
    [cell setCellIndexPath:indexPath];
    [cell configWithData:itemModel.data];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self sectionModelAtSection:section].headerView?:[UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self sectionModelAtSection:section].footerView?:[UIView new];
}

#pragma mark - UITableViewDelegate
#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SFTableViewItemModel *itemModel = [self itemAtIndexPath:indexPath];
    if (itemModel.cellSelectBlock) {
        itemModel.cellSelectBlock(itemModel, indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SFTableViewItemModel *itemModel = [self itemAtIndexPath:indexPath];
    return [NSClassFromString(itemModel.className) cellHeight:itemModel.data];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SFTableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    CGFloat height = sectionModel.headerHeight;
    if (height > 0) {
        return height;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SFTableViewSectionModel *sectionModel = [self sectionModelAtSection:section];
    CGFloat height = sectionModel.footerHeight;
    if (height > 0) {
        return height;
    }
    return 0.01;
}

#pragma mark - CollectionDelegate
#pragma mark -
//手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
   // SFLog(@"begin %lf",scrollView.contentOffset.y);
}

//手指拖动停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //SFLog(@"end %lf",scrollView.contentOffset.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //SFLog(@"scrollView %lf",scrollView.contentOffset.y);
}


#pragma mark - private
#pragma mark -
- (SFTableViewSectionModel *)sectionModelAtSection:(NSInteger)section{
    if (section < self.sections.count) {
        return self.sections[section];
    }
    return nil;
}

- (SFTableViewItemModel *)itemModelAtIndexPath:(NSIndexPath *)indexPath{
    SFTableViewSectionModel *sectionModel = [self sectionModelAtSection:indexPath.section];
    if (sectionModel && sectionModel.items.count > indexPath.row) {
        return sectionModel.items[indexPath.row];
    }
    return nil;
}

@end
