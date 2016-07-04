//
//  BLAnimatableNavBar.h
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BLAnimatableNavBarBehavior.h"
#import "BLSubviewLayoutAttributes.h"
#import "UIView+BLSubview.h"

@interface BLAnimatableNavBar : UIToolbar

/**
*  用于控制navBar的高度，如果'elastic'是NO，progress~[0.0, 1.0], 0.0显示最大高度，1.0显示做小高度
*/
@property (nonatomic) CGFloat progress;

/**
 *  navBar的最大高度，默认44.0
 */
@property (nonatomic) CGFloat maximumBarHeight;

/**
 *  navBar的最小高度，默认20.0
 */
@property (nonatomic) CGFloat minimumBarHeight;

/**
 *  运行时控制可动画行为
 */
@property (nonatomic) BLAnimatableNavBarBehavior *behavior;

@end
