//
//  UIView+BLSubview.h
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLSubviewLayoutAttributes;

@interface UIView (BLSubview)

/**
*  添加progress所对应的layout attributes
*
*  @param layoutAttributes latyou attributes
*  @param progress         progress ~ [0.0, 1.0]
*/
- (void)addLayoutAttributes:(BLSubviewLayoutAttributes *)layoutAttributes forProgress:(CGFloat)progress;

/**
 *  移除progress所对应的layout attributes
 *
 *  @param progress         progress ~ [0.0, 1.0]
 */
- (void)removeLayoutAttributesForProgress:(CGFloat)progress;

/**
 *  latyou attributes的数量
 *
 *  @return latyou attributes的数量
 */
- (NSUInteger)numberOfLayoutAttributes;

/**
 *  返回index所对应的progress
 *
 *  @param index 索引
 *
 *  @return 返回对应的progress
 */
- (CGFloat)progressAtIndex:(NSUInteger)index;

/**
 Returns the layout attributes corresponding to the specified index. This is a helper method for `BLKFlexibleHeightBar.`
 @param The index of the desired layout attributes.
 @return The layout attributes corresponding to the specified index.
 */
/**
 *  返回index所对应的layout attributes
 *
 *  @param index 索引
 *
 *  @return 返回index所对应的layout attributes
 */
- (BLSubviewLayoutAttributes *)layoutAttributesAtIndex:(NSUInteger)index;

@end
