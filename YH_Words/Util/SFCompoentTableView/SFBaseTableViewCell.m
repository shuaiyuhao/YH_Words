//
//  SFBsaeTableViewCell.m
//  zhichaoyijia-client
//
//  Created by xiaohuodui-2 on 2019/11/4.
//  Copyright © 2019 xiaohuodui. All rights reserved.
//

#import "SFBaseTableViewCell.h"
#import "UIView+SFAddLine.h"

@interface SFBaseTableViewCell ()

@end

@implementation SFBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
    }
    return self;
}

- (void)layoutPageViews{
    
}

+ (CGFloat)cellHeight:(id)data{
    if(data && [data isKindOfClass:[SFBaseTableViewModel class]]){
        SFBaseTableViewModel *model = data;
        if(model.height){
            return model.height;
        }
    }
    return 88.f;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (void)configWithData:(id)data {
    
}

- (void)setCellIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

- (void)showLineWithTop:(BOOL)top bottom:(BOOL)bottom{
    [self sf_addLineTop:top bottom:bottom leftSpace:10 rightSpace:10];
}

- (void)setCanEdit:(BOOL)canEdit{
    _canEdit = canEdit;
    if (canEdit) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (void)setCanSelect:(BOOL)canSelect{
    _canSelect = canSelect;
    if (canSelect) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else{
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

@end
