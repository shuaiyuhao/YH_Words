//
//  YTKBatchRequest+SFHUDAccessory.m
//  JingzhanCar
//
//  Created by liuliu zhang on 2018/10/9.
//  Copyright © 2018 xiaohuodui. All rights reserved.
//

#import "YTKBatchRequest+SFHUDAccessory.h"

@implementation YTKBatchRequest (SFHUDAccessory)

- (SFHUDRequestAccessory *)hudRequestAccessory {
    for (id accessory in self.requestAccessories) {
        if ([accessory isKindOfClass:[SFHUDRequestAccessory class]]) {
            return accessory;
        }
    }
    return nil;
}

- (SFHUDType)hudType {
    return [self hudRequestAccessory].hudType;
}

- (void)setHudType:(SFHUDType)hudType {
    if (![self hudRequestAccessory]) {
        if (self.requestAccessories) {
            [self.requestAccessories insertObject:[SFHUDRequestAccessory accessoryWithHUDType:hudType text:nil] atIndex:0];
        }else {
            [self addAccessory:[SFHUDRequestAccessory accessoryWithHUDType:hudType text:nil]];
        }
    }else {
        [self hudRequestAccessory].hudType = hudType;
    }
}

- (NSString *)text {
    return [self hudRequestAccessory].text;
}

- (void)setText:(NSString *)text {
    if (![self hudRequestAccessory]) {
        if (self.requestAccessories) {
            [self.requestAccessories insertObject:[SFHUDRequestAccessory accessoryWithHUDType:SFHUDTypeProgressAlert text:text] atIndex:0];
        }else {
            [self addAccessory:[SFHUDRequestAccessory accessoryWithHUDType:SFHUDTypeProgressAlert text:text]];
        }
        
    }else {
        [self hudRequestAccessory].text = text;
    }
}

@end
