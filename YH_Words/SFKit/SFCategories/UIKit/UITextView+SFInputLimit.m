//
//  UITextView+SFInputLimit.m
//  Subway
//
//  Created by liuliu zhang on 2017/12/2.
//  Copyright © 2017年 SamllFire. All rights reserved.
//

#import "UITextView+SFInputLimit.h"
#import <objc/runtime.h>

static const void *SFTextViewInputLimitMaxLengthKey = &SFTextViewInputLimitMaxLengthKey;

@implementation UITextView (SFInputLimit)

- (NSInteger)sf_maxLength{
    return [objc_getAssociatedObject(self, SFTextViewInputLimitMaxLengthKey) integerValue];
}

- (void)setSf_maxLength:(NSInteger)sf_maxLength{
    objc_setAssociatedObject(self, SFTextViewInputLimitMaxLengthKey, @(sf_maxLength), OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sf_textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)sf_textViewTextDidChange:(NSNotification *)notification{
    if (self.sf_maxLength > 0) {
        UITextRange *selectedRange = [self markedTextRange];
        if (selectedRange && selectedRange.start) { return; }
        if (self.text.length > self.sf_maxLength) {
            self.text = [self.text substringToIndex:self.sf_maxLength];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
