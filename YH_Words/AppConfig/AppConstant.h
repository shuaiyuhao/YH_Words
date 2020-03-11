//
//  AppConstant.h
//  YH_Words
//
//  Created by Yuhao on 2020/3/12.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#ifndef AppConstant_h
#define AppConstant_h

#import <UIKit/UIKit.h>

typedef void (^SFVoidActionBlock)(void);

typedef void (^SFIndexActionBlock)(NSInteger index);

typedef void (^SFStringActionBlock)(NSString *index);

typedef void (^SFObjectActionBlock)(id object);

typedef void (^SFTypeActionBlock)(id type);

typedef void (^SFControllerDismissBlock)(id data);

typedef void(^SFCollectionCCellDidBlock)(id data,NSIndexPath *indexPath);


static NSString * const kTokenExpiredNotification              = @"kTokenExpiredNotification";
static NSString * const kUpdateSuppliersNotification           = @"kUpdateSuppliersNotification";
static NSString * const kUpdateAddressNotification           = @"kUpdateAddressNotification";
static NSString * const kUpdateUserInfoNotification           = @"kUpdateUserInfoNotification";
static NSString * const kIdentiNotification           = @"kIdentiNotification";
static NSString * const kUpdateInquiryNotification           = @"kUpdateInquiryNotification";
static NSString * const kUpdateOfferNotification           = @"kUpdateOfferNotification";
static NSString * const kUpdateOrderNotification           = @"kUpdateOrderNotification";
static NSString * const kUpdateLookNotification           = @"kUpdateLookNotification";
static NSString * const kUpdateCartNotification           = @"kUpdateCartNotification";
static NSString * const kUpdateContractNotification           = @"kUpdateContractNotification";
static NSString * const kUpdateMessageNotification           = @"kUpdateMessageNotification";

#endif /* AppConstant_h */
