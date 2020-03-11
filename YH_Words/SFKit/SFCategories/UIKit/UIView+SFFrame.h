//
//  UIView+SFFrame.h
//  Pods
//
//  Created by zhang on 16/6/12.
//
//

#import <UIKit/UIKit.h>

@interface UIView (SFFrame)

@property (nonatomic, assign) CGFloat sf_x;
@property (nonatomic, assign) CGFloat sf_y;
@property (nonatomic, assign) CGPoint sf_origin;
@property (nonatomic, assign) CGFloat sf_centerX;
@property (nonatomic, assign) CGFloat sf_centerY;
@property (nonatomic, assign) CGFloat sf_width;
@property (nonatomic, assign) CGFloat sf_height;
@property (nonatomic, assign) CGSize  sf_size;

@property (nonatomic, assign) CGFloat sf_top;
@property (nonatomic, assign) CGFloat sf_bottom;
@property (nonatomic, assign) CGFloat sf_left;
@property (nonatomic, assign) CGFloat sf_right;

- (void)printFrame;

- (void)printBounds;

- (void)sf_addSubviews:(NSArray *_Nonnull)array;

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)sf_snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 */
- (nullable UIImage *)sf_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

@end
