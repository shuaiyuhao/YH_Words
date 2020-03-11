//
//  UITextField+SFInputLimit.m
//  Subway
//
//  Created by liuliu zhang on 2017/12/2.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import "UITextField+SFInputLimit.h"
#import <objc/runtime.h>

static const void *SFTextFieldInputLimitMaxLengthKey = &SFTextFieldInputLimitMaxLengthKey;

@implementation UITextField (SFInputLimit)

- (NSInteger)sf_maxLength{
    return [objc_getAssociatedObject(self, SFTextFieldInputLimitMaxLengthKey) integerValue];
}

- (void)setSf_maxLength:(NSInteger)sf_maxLength{
    objc_setAssociatedObject(self, SFTextFieldInputLimitMaxLengthKey, @(sf_maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(sf_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)sf_textFieldTextDidChange{
    if (self.sf_maxLength > 0) {
        UITextRange *selectedRange = [self markedTextRange];
        if (selectedRange && selectedRange.start) { return; }
        if (self.text.length > self.sf_maxLength) {
            self.text = [self.text substringToIndex:self.sf_maxLength];
        }
    }
}

@end
