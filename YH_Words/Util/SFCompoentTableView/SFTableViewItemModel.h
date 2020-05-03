//
//  SFTableViewItemModel.h
//  Subway
//
//  Created by liuliu zhang on 2017/12/10.
//Copyright © 2017年 SamllFire. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SFTableViewCellDidSelectBlock)(id item, NSIndexPath *indexPath);

@interface SFTableViewItemModel : NSObject

@property (nonatomic,copy) SFTableViewCellDidSelectBlock cellSelectBlock;
@property (nonatomic,copy) NSString *className;
@property (nonatomic,strong) id data;

- (instancetype)initWithData:(id)data className:(NSString *)className;

@end
