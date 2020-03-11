//
//  NSObject+SFImagePicker.h
//  SFKit
//
//  Created by liuliu zhang on 2018/5/27.
//

#import <Foundation/Foundation.h>

typedef void (^SFImagePickerDidSelectBlock)(NSArray *assets);

@interface NSObject (SFImagePicker)

- (void)getPhotoWithCrop:(BOOL)crop photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock;

//- (void)getPhotoWithCropRect:(CGRect)cropRect photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock;

- (void)getPhotosWithMaxImagesCount:(NSInteger)maxCount photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock;

- (void)takePhotoWithCrop:(BOOL)crop photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock;

//- (void)takePhotoWithCropRect:(CGRect)cropRect photoDidSelectBlock:(SFImagePickerDidSelectBlock)photoDidSelectBlock;

- (void)captureVideoWithCompletion:(SFImagePickerDidSelectBlock)completion;

@end
