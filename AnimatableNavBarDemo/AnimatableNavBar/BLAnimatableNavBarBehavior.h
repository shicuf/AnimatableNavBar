//
//  BLAnimatableNavBarBehavior.h
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BLAnimatableNavBar;

@interface BLAnimatableNavBarBehavior : NSObject <UIScrollViewDelegate>

/**
 *  有可动画行为的navBar
 */
@property (nonatomic, readonly, weak) BLAnimatableNavBar *animatableNavBar;

/**
 *  是否有弹性
 */
@property (nonatomic, getter=isSnappingEnabled) BOOL snappingEnabled;

/**
 *  当前是否在弹性状态
 */
@property (nonatomic, getter=isCurrentlySnapping) BOOL currentlySnapping;

/**
 *  拖拽时是否可以超过做大高度,即是否需要弹性效果，默认是NO
 */
@property (nonatomic, getter=isElastic) BOOL elastic;

/**
 *  添加吸附位置
 *
 *  @param progress 将要吸附到的位置progress
 *  @param start    范围的起点progress
 *  @param end      范围的终点progress
 */
- (void)addSnappingPositionProgress:(CGFloat)progress fromStartProgress:(CGFloat)start toEndProgress:(CGFloat)end;

/**
 *  移除吸附位置
 *
 *  @param start 被移除的起点progress
 *  @param end   被移除的终点progress
 */
- (void)removeSnappingPositionProgressForStartProgress:(CGFloat)start endProgress:(CGFloat)end;

/**
 *  将navBar吸附到指定progress
 *
 *  @param progress   将要吸附到的指定的progress
 *  @param scrollView 自适应偏移量的scrollView
 */
- (void)snapToProgress:(CGFloat)progress scrollView:(UIScrollView *)scrollView;

/**
 *  根据当前progress，吸附到目的progress
 *
 *  @param scrollView 自适应偏移量的scrollView
 */
- (void)snapWithScrollView:(UIScrollView *)scrollView;

/**
 *  UIScrollViewDelegate的方法被调用时更新snap
 *
 *  @param scrollView 被监听的scrollView，子类实现需要调用父类的实现
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

/**
 *  UIScrollViewDelegate的方法被调用时更新snap
 *
 *  @param scrollView 被监听的scrollView，子类实现需要调用父类的实现
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

/**
 *  scrollView 滚动时调用
 *
 *  @param scrollView 被监听的scrollView，子类实现需要调用父类的实现
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

/**
 *  全部展示
 */
- (void)snapToResetProgress;

@end
