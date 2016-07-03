//
//  BLSubviewLayoutAttributes.h
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLSubviewLayoutAttributes : NSObject

/**
 *  控件的frame
 */
@property (nonatomic) CGRect frame;

/**
 *  控件的bounds
 */
@property (nonatomic) CGRect bounds;

/**
 *  控件的center
 */
@property (nonatomic) CGPoint center;

/**
 *  控件的size
 */
@property (nonatomic) CGSize size;

/**
 *  3D transform属性
 */
@property (nonatomic) CATransform3D transform3D;

/**
 *  transform属性
 */
@property (nonatomic) CGAffineTransform transform;

/**
 *  透明度
 */
@property (nonatomic) CGFloat alpha;

/**
 *  z坐标
 *  默认值是0.0
 */
@property (nonatomic) NSInteger originZ;

/**
 *  是否隐藏
 */
@property (nonatomic, getter=isHidden) BOOL hidden;


/**
 A convenience initializer that returns layout attributes with the same property values as the specified layout attributes, or nil of initialization fails.
 @param The existing layout attributes.
 @return Layout attributes with the same property values as the specified layout attributes, or nil of initialization fails.
 */
- (instancetype)initWithExistingLayoutAttributes:(BLSubviewLayoutAttributes *)layoutAttributes;
@end
