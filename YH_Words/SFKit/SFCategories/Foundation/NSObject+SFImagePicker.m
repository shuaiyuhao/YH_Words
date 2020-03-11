//
//  NSObject+SFImagePicker.m
//  SFKit
//
//  Created by liuliu zhang on 2018/5/27.
//

#import "NSObject+SFImagePicker.h"
#import <objc/runtime.h>
#import <Photos/Photos.h>
#import "TZImagePickerController.h"
#import "RSKImageCropViewController.h"
#import "UIViewController+SFAdd.h"

@interface SFImagePickerDelegate : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate, RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource>

/**
 是否需要裁剪
 */
@property (nonatomic,assign) BOOL needCrop;

/**
 裁剪区域大小
 */
@property (nonatomic,assign) CGRect cropRect;

@property (nonatomic,copy) SFImagePickerDidSelectBlock didSelectBlock;

@end

@implementation SFImagePickerDelegate

#pragma mark - UIImagePickerControllerDelegate
#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mType = [info valueForKey:UIImagePickerControllerMediaType];
    if([mType isEqualToString:@"public.movie"]){
        //video todo
        
    }else{
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        if (self.needCrop) {
            [picker dismissViewControllerAnimated:YES completion:^{
               [self toCropImage:image];
            }];
            
        }else{
            
            if (self.didSelectBlock) {
                self.didSelectBlock(@[image]);
            }
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - RSKImageCropViewControllerDelegate
#pragma mark -
- (void)imageCropViewController:(nonnull RSKImageCropViewController *)controller didCropImage:(nonnull UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle {
    if (self.didSelectBlock) {
        self.didSelectBlock(@[croppedImage]);
    }
    
    [controller.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewControllerDidCancelCrop:(nonnull RSKImageCropViewController *)controller {
    [controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark - RSKImageCropViewControllerDataSource
#pragma mark -
- (nonnull UIBezierPath *)imageCropViewControllerCustomMaskPath:(nonnull RSKImageCropViewController *)controller {
    CGRect rect = controller.maskRect;
    CGPoint point1 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint point2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint point3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPoint point4 = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    
    UIBezierPath *square = [UIBezierPath bezierPath];
    [square moveToPoint:point1];
    [square addLineToPoint:point2];
    [square addLineToPoint:point3];
    [square addLineToPoint:point4];
    [square closePath];
    
    return square;
}

- (CGRect)imageCropViewControllerCustomMaskRect:(nonnull RSKImageCropViewController *)controller {
    CGSize maskSize = self.cropRect.size;
    
    CGFloat viewWidth = CGRectGetWidth(controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);
    
    CGRect maskRect = CGRectMake((viewWidth - maskSize.width) * 0.5f,
                                 (viewHeight - maskSize.height) * 0.5f,
                                 maskSize.width,
                                 maskSize.height);
    return maskRect;
}

- (CGRect)imageCropViewControllerCustomMovementRect:(nonnull RSKImageCropViewController *)controller {
    return controller.maskRect;
}

#pragma mark - private
#pragma mark -
/**
 裁剪图片
 
 @param image image
 */
-(void)toCropImage:(UIImage*)image{
    RSKImageCropViewController *imageCropVC=[[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeCircle];
    imageCropVC.hidesBottomBarWhenPushed = YES;
    
    if (CGRectEqualToRect(CGRectZero, self.cropRect)) {
        imageCropVC.dataSource = nil;
        imageCropVC.cropMode = RSKImageCropModeCircle;
    }else{
        imageCropVC.dataSource = self;
        imageCropVC.cropMode = RSKImageCropModeCustom;
    }
    imageCropVC.delegate = self;
    
    UIViewController *currentViewController = [UIViewController topViewController];
    
    if ([currentViewController isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nav = ((UITabBarController *)self).selectedViewController;
        [nav pushViewController:imageCropVC animated:YES];
    }else{
        [currentViewController.navigationController pushViewController:imageCropVC animated:YES];
    }
}

@end

@interface NSObject ()

@property (nonatomic,strong) SFImagePickerDelegate *imagePickerDelegate;

@end

@implementation NSObject (SFImagePicker)

- (void)getPhotoWithCrop:(BOOL)crop photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock{
    [self obtainPhotoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary needCrop:crop cropRect:CGRectZero photoDidSelectBlock:photoDidSelectBlock];
}

- (void)getPhotoWithCropRect:(CGRect)cropRect photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock{
    BOOL crop = !CGRectEqualToRect(cropRect, CGRectZero);
    [self obtainPhotoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary needCrop:crop cropRect:cropRect photoDidSelectBlock:photoDidSelectBlock];
}

- (void)getPhotosWithMaxImagesCount:(NSInteger)maxCount photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount delegate:nil];
    imagePickerVc.allowCrop = NO;
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photoDidSelectBlock) {
            photoDidSelectBlock(photos);
        }
    }];
    
    [[UIViewController topViewController] presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)takePhotoWithCrop:(BOOL)crop photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock{
    [self obtainPhotoWithSourceType:UIImagePickerControllerSourceTypeCamera needCrop:crop cropRect:CGRectZero photoDidSelectBlock:photoDidSelectBlock];
}

- (void)takePhotoWithCropRect:(CGRect)cropRect photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock{
    BOOL crop = !CGRectEqualToRect(cropRect, CGRectZero);
    [self obtainPhotoWithSourceType:UIImagePickerControllerSourceTypeCamera needCrop:crop cropRect:cropRect photoDidSelectBlock:photoDidSelectBlock];
}

- (void)captureVideoWithCompletion:(SFImagePickerDidSelectBlock)completion{
    //todo
}

#pragma mark - getter and setter
#pragma mark -
- (SFImagePickerDelegate *)imagePickerDelegate{
    return objc_getAssociatedObject(self, @selector(imagePickerDelegate));
}

- (void)setImagePickerDelegate:(SFImagePickerDelegate *)imagePickerDelegate{
    objc_setAssociatedObject(self, @selector(imagePickerDelegate), imagePickerDelegate, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - private
#pragma mark -
- (void)obtainPhotoWithSourceType:(UIImagePickerControllerSourceType)sourceType needCrop:(BOOL)crop cropRect:(CGRect)cropRect photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock{
    __weak NSObject *weakSelf = self;
    [self obtainPermissionForMediaSourceType:sourceType withSuccessHandler:^{
        UIImagePickerController *imagePickerController = [weakSelf setUpImagePickerWithSourceType:sourceType];
        if (weakSelf.imagePickerDelegate == nil) {
            weakSelf.imagePickerDelegate = [SFImagePickerDelegate new];
        }
        weakSelf.imagePickerDelegate.needCrop = crop;
        weakSelf.imagePickerDelegate.cropRect = cropRect;
        weakSelf.imagePickerDelegate.didSelectBlock = photoDidSelectBlock;
        imagePickerController.delegate = weakSelf.imagePickerDelegate;
        
        [[UIViewController topViewController] presentViewController:imagePickerController animated:YES completion:nil];
        
    } failureHandler:^{
        
    }];
}

- (UIImagePickerController *)setUpImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = NO;
    return imagePickerController;
}

- (void)obtainPermissionForMediaSourceType:(UIImagePickerControllerSourceType)sourceType withSuccessHandler:(void (^) (void))successHandler failureHandler:(void (^) (void))failureHandler {
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary || sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            switch (status) {
                case PHAuthorizationStatusNotDetermined:
                case PHAuthorizationStatusAuthorized: {
                    if (successHandler){
                        dispatch_async (dispatch_get_main_queue (), ^{ successHandler (); });
                    }
                };
                    break;
                    
                case PHAuthorizationStatusRestricted:
                case PHAuthorizationStatusDenied:{
                    if (failureHandler){
                        dispatch_async (dispatch_get_main_queue (), ^{ failureHandler (); });
                    }
                };
                    break;
                    
                default:
                    break;
            }
        }];
    }else if (sourceType == UIImagePickerControllerSourceTypeCamera){
        // Checks for Camera access:
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (status){
            case AVAuthorizationStatusAuthorized:{
                if (successHandler)
                    dispatch_async (dispatch_get_main_queue (), ^{ successHandler (); });
            };
                break;
            case AVAuthorizationStatusNotDetermined:{
                // seek access first:
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if(granted){
                        if (successHandler)
                            dispatch_async (dispatch_get_main_queue (), ^{ successHandler (); });
                    } else {
                        if (failureHandler)
                            dispatch_async (dispatch_get_main_queue (), ^{ failureHandler (); });
                    }
                }];
            };
                break;
                
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
            default:{
                if (failureHandler)
                    dispatch_async (dispatch_get_main_queue (), ^{ failureHandler (); });
            };
                break;
        }
    }
    else{
        NSAssert(NO, @"Permission type not found");
    }
}

@end
