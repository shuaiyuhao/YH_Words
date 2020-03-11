//
//  NSObject+SFHelper.m
//  zhichaoyijia-client
//
//  Created by xiaohuodui-2 on 2019/10/28.
//  Copyright © 2019 xiaohuodui. All rights reserved.
//

#import "NSObject+SFHelper.h"
#import "UIButton+SFBuilder.h"
#import <Accelerate/Accelerate.h>
#import "UIGestureRecognizer+SFFly.h"
#import <MMPopupWindow.h>

@interface NSObject ()

@end

@implementation NSObject (SFHelper)

- (void)toBorderColor:(UIColor *)color toBorderWidth:(CGFloat)borderWidth withUIView:(UIView *)view{
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = borderWidth;
}

- (void)toCornradius:(CGFloat)cornerRadius with:(UIView *)view{
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}

- (UIImage *)imageRedToWhiteWithRect:(CGRect)rect allSize:(CGSize)allSize{
    UIImage *image = [self gradientColorImageFromColors:@[
        [UIColor colorWithHexString:@"0xD95859"],
        [UIColor colorWithHexString:@"0xFFFFFF"],
    ] gradientType:SFGradientTypeTopToBottom imgSize:allSize];
    return [self partImageWithRect:rect image:image];
}

- (UIImage *)partImageWithRect:(CGRect)rect image:(UIImage *)image{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    return [UIImage imageWithCGImage:imageRef];
}

- (UIWindow *)lastWindowOrMMPopupWindow{
    NSArray *array = [UIApplication sharedApplication].windows;
    __block UIWindow *window = nil;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj && [obj isKindOfClass:[MMPopupWindow class]]) {
            window = obj;
        }
    }];
    return window?:[[UIApplication sharedApplication].windows lastObject];
}

- (void)configAction:(UIView *)view withActionBlock:(SFObjectActionBlock)block{
    if ([view isKindOfClass:[UIView class]] || [view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UIImageView class]]) {
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [UITapGestureRecognizer sf_gestureRecognizerWithHandler:^(id sender) {
            if(block){
                block(sender);
            }
        }];
        [view addGestureRecognizer:tap];
    }
}

- (CGSize)getStringSizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

- (id)sf_stringToJSONObject:(NSString *)jsonString{
    if(!(jsonString && jsonString.length)){
        SFLog(@"sf_stringToJSONObject error : string = NULL");
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&localError];
    return jsonObject;
}

- (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(SFGradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case SFGradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case SFGradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case SFGradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case SFGradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

- (UIButton *)buttonWithColors:(NSArray<UIColor *> *)color size:(CGSize)size{
    UIButton *button = UIButton.builder()
    .font([UIFont systemFontOfSize:14])
    .build();
    UIImage *image = [self gradientColorImageFromColors:color gradientType:SFGradientTypeLeftToRight imgSize:size];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    return button;
}

- (UIButton *)buttonWithSize:(CGSize)size{
    return [self buttonWithColors:@[
    [UIColor colorWithHexString:@"0x48C6EF"],
    [UIColor colorWithHexString:@"0x1890FF"],
    ] size:size];
}
@end
