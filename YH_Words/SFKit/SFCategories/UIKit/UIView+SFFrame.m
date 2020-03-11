//
//  UIView+SFFrame.m
//  Pods
//
//  Created by zhang on 16/6/12.
//
//

#import "UIView+SFFrame.h"

@implementation UIView (SFFrame)

- (void)setSf_x:(CGFloat)sf_x{
    CGRect frame = self.frame;
    frame.origin.x = sf_x;
    self.frame = frame;
}

- (CGFloat)sf_x{
    return CGRectGetMinX(self.frame);
}

- (void)setSf_y:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)sf_y{
    return CGRectGetMinY(self.frame);
}

- (CGPoint)sf_origin {
    return self.frame.origin;
}

- (void)setSf_origin:(CGPoint)sf_origin {
    CGRect frame = self.frame;
    frame.origin = sf_origin;
    self.frame = frame;
}

- (void)setSf_centerX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)sf_centerX{
    
    return self.center.x;
}

- (void)setSf_centerY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)sf_centerY{
    return self.center.y;
}

- (void)setSf_width:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)sf_width{
    return CGRectGetWidth(self.frame);
}

- (void)setSf_height:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)sf_height{
    return CGRectGetHeight(self.frame);
}

- (void)setSf_size:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)sf_size{
    return self.frame.size;
}

- (void)setSf_top:(CGFloat)t{
    self.frame = CGRectMake(self.sf_left, t, self.sf_width, self.sf_height);
}

- (CGFloat)sf_top{
    return self.frame.origin.y;
}

- (void)setSf_bottom:(CGFloat)b{
    self.frame = CGRectMake(self.sf_left, b - self.sf_height, self.sf_width, self.sf_height);
}

- (CGFloat)sf_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSf_left:(CGFloat)l{
    self.frame = CGRectMake(l, self.sf_top, self.sf_width, self.sf_height);
}

- (CGFloat)sf_left{
    return self.frame.origin.x;
}

- (void)setSf_right:(CGFloat)sf_right{
    self.frame = CGRectMake(sf_right - self.sf_width, self.sf_top, self.sf_width, self.sf_height);
}

- (CGFloat)sf_right{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)printFrame{
    NSLog(@"view.frame = %@",NSStringFromCGRect(self.frame));
}

-(void)printBounds{
    NSLog(@"bounds = %@",NSStringFromCGRect(self.bounds));
}

- (UIImage *)sf_snapshotImage {
    //scale设为0之后，系统就会自动设置正确的缩放比例了，当然也可以用[UIScreen mainScreen].scale
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)sf_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self sf_snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (void)sf_addSubviews:(NSArray *)array{
    for (UIView *view in array) {
        [self addSubview:view];
    }
}

@end
