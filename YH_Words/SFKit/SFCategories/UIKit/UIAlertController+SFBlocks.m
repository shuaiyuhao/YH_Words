//
//  UIAlertController+SFBlocks.m
//  SFKit
//
//  Created by liuliu zhang on 2018/11/9.
//

#import "UIAlertController+SFBlocks.h"

static NSInteger const UIAlertControllerBlocksCancelButtonIndex = 0;
static NSInteger const UIAlertControllerBlocksDestructiveButtonIndex = 1;
static NSInteger const UIAlertControllerBlocksFirstOtherButtonIndex = 2;

@interface UIViewController (UACB_Topmost)

- (UIViewController *)uacb_topmost;

@end

@implementation UIAlertController (SFBlocks)

+ (instancetype)showInViewController:(UIViewController *)viewController
                           withTitle:(NSString *)title
                             message:(NSString *)message
                      preferredStyle:(UIAlertControllerStyle)preferredStyle
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
                            tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    UIAlertController *strongController = [self alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:preferredStyle];
    
    __weak UIAlertController *controller = strongController;
    
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action){
                                                                 if (tapBlock) {
                                                                     tapBlock(controller, action, UIAlertControllerBlocksCancelButtonIndex);
                                                                 }
                                                             }];
        [controller addAction:cancelAction];
    }
    
    if (destructiveButtonTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                                    style:UIAlertActionStyleDestructive
                                                                  handler:^(UIAlertAction *action){
                                                                      if (tapBlock) {
                                                                          tapBlock(controller, action, UIAlertControllerBlocksDestructiveButtonIndex);
                                                                      }
                                                                  }];
        [controller addAction:destructiveAction];
    }
    
    for (NSUInteger i = 0; i < otherButtonTitles.count; i++) {
        NSString *otherButtonTitle = otherButtonTitles[i];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action){
                                                                if (tapBlock) {
                                                                    tapBlock(controller, action, UIAlertControllerBlocksFirstOtherButtonIndex + i);
                                                                }
                                                            }];
        [controller addAction:otherAction];
    }
    
    [viewController.uacb_topmost presentViewController:controller animated:YES completion:nil];
    
    return controller;
}

+ (instancetype)showAlertInViewController:(UIViewController *)viewController
                                withTitle:(NSString *)title
                                  message:(NSString *)message
                        cancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles
                                 tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self showInViewController:viewController
                            withTitle:title
                              message:message
                       preferredStyle:UIAlertControllerStyleAlert
                    cancelButtonTitle:cancelButtonTitle
               destructiveButtonTitle:destructiveButtonTitle
                    otherButtonTitles:otherButtonTitles
                             tapBlock:tapBlock];
}

+ (instancetype)showActionSheetInViewController:(UIViewController *)viewController
                                      withTitle:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                         destructiveButtonTitle:(NSString *)destructiveButtonTitle
                              otherButtonTitles:(NSArray *)otherButtonTitles
                                       tapBlock:(UIAlertControllerCompletionBlock)tapBlock
{
    return [self showInViewController:viewController
                            withTitle:title
                              message:message
                       preferredStyle:UIAlertControllerStyleActionSheet
                    cancelButtonTitle:cancelButtonTitle
               destructiveButtonTitle:destructiveButtonTitle
                    otherButtonTitles:otherButtonTitles
                             tapBlock:tapBlock];
}

#pragma mark -

- (BOOL)visible
{
    return self.view.superview != nil;
}

- (NSInteger)cancelButtonIndex
{
    return UIAlertControllerBlocksCancelButtonIndex;
}

- (NSInteger)firstOtherButtonIndex
{
    return UIAlertControllerBlocksFirstOtherButtonIndex;
}

- (NSInteger)destructiveButtonIndex
{
    return UIAlertControllerBlocksDestructiveButtonIndex;
}

@end

@implementation UIViewController (UACB_Topmost)

- (UIViewController *)uacb_topmost
{
    UIViewController *topmost = self;
    
    UIViewController *above;
    while ((above = topmost.presentedViewController)) {
        topmost = above;
    }
    
    return topmost;
}

@end
