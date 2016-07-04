//
//  BLSplitterDelegate.h
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLSplitterDelegate : NSObject

/**
 * UIScrollView的附加代理
 */
@property (nonatomic, weak) id<NSObject> additionalDelegate;

/**
 * UIScrollView的原有代理
 */
@property (nonatomic, weak) id<NSObject> originalDelegate;

/**
 *  实例化一个分类器代理
 *
 *  @param secondDelegate 附加代理
 *  @param firstDelegate  原有代理
 *
 *  @return 返回分类器代理
 */
- (instancetype)initWithAdditionalDelegate:(id<NSObject>)additionalDelegate originalDelegate:(id<NSObject>)originalDelegate;

@end
