//
//  YHTitleFieldView.h
//  YH_Words
//
//  Created by Yuhao on 2020/3/12.
//  Copyright © 2020 Vwidea. All rights reserved.
//

#import "YHBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHTitleFieldView : YHBaseView

@property (nonatomic,strong) SFStringActionBlock textChangeBlock;

@property (nonatomic,strong) SFIndexActionBlock buttonActionBlock;

- (void)configWithTitle:(NSString *)title palceHolder:(NSString *)placeHolder showImage:(UIImage *)image keyBoardType:(UIKeyboardType)keyBoardType secureTextEntry:(BOOL)secureTextEntry;

- (void)setShowImage:(UIImage *)showImage secureTextEntry:(BOOL)secureTextEntry;

- (void)configWithTitle:(NSString *)title placeholder:(NSString *)placeholder customView:(id)customView keyBoardType:(UIKeyboardType)keyBoardType secureTextEntry:(BOOL)secureTextEntry;

@end

NS_ASSUME_NONNULL_END
