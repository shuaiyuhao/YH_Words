//
//  UIAlertController+SFBlocks.h
//  SFKit
//
//  Created by liuliu zhang on 2018/11/9.
//

#import <UIKit/UIKit.h>

/**
 设置颜色的方式：
 
 1. [UIView appearanceWhenContainedInInstancesOfClasses:@[[UIAlertController class]]].tintColor = [UIColor yellowColor];
 2. alertController.tintColor = [UIColor yellowColor];
 */

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (SFBlocks)

typedef void (^UIAlertControllerCompletionBlock) (UIAlertController * __nonnull controller, UIAlertAction * __nonnull action, NSInteger buttonIndex);

+ (nonnull instancetype)showInViewController:(nonnull UIViewController *)viewController
                                   withTitle:(nullable NSString *)title
                                     message:(nullable NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle
                           cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                           otherButtonTitles:(nullable NSArray *)otherButtonTitles
                                    tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

+ (nonnull instancetype)showAlertInViewController:(nonnull UIViewController *)viewController
                                        withTitle:(nullable NSString *)title
                                          message:(nullable NSString *)message
                                cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                           destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                otherButtonTitles:(nullable NSArray *)otherButtonTitles
                                         tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;


+ (nonnull instancetype)showActionSheetInViewController:(nonnull UIViewController *)viewController
                                              withTitle:(nullable NSString *)title
                                                message:(nullable NSString *)message
                                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                 destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                                      otherButtonTitles:(nullable NSArray *)otherButtonTitles
                                               tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;


@property (readonly, nonatomic) BOOL visible;
@property (readonly, nonatomic) NSInteger cancelButtonIndex;
@property (readonly, nonatomic) NSInteger firstOtherButtonIndex;
@property (readonly, nonatomic) NSInteger destructiveButtonIndex;

@end

NS_ASSUME_NONNULL_END
