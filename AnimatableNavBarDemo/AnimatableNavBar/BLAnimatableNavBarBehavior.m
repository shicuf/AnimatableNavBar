//
//  BLAnimatableNavBarBehavior.m
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import "BLAnimatableNavBarBehavior.h"
#import "BLAnimatableNavBar.h"

@interface BLAnimatableNavBarBehavior ()

@property (nonatomic) NSMutableDictionary *progressRanges;

//- (void)BLK_Private_setFlexibleHeightBar:(BLKFlexibleHeightBar *)flexibleHeightBar;
- (void)setAnimatableNavBar:(BLAnimatableNavBar *)animatableNavBar;

@end

@implementation BLAnimatableNavBarBehavior

- (instancetype)init {
    if (self = [super init]) {
        _progressRanges = [[NSMutableDictionary alloc] init];
        _snappingEnabled = YES;
        _currentlySnapping = NO;
        _elastic = NO;
    }
    
    return self;
}

- (void)setAnimatableNavBar:(BLAnimatableNavBar *)animatableNavBar {
    if(_animatableNavBar != animatableNavBar) {
        _animatableNavBar = animatableNavBar;
    }
}

# pragma mark - Snapping

- (void)addSnappingPositionProgress:(CGFloat)progress fromStartProgress:(CGFloat)start toEndProgress:(CGFloat)end {
    // Make sure start and end are between 0 and 1
    start = fmax(fmin(start, 1.0), 0.0) * 100.0;
    end = fmax(fmin(end, 1.0), 0.0) * 100.0;
    NSRange progressPercentRange = NSMakeRange(start, end-start);
    
    [self.progressRanges enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSValue *existingRangeValue = key;
        NSRange existingRange = [existingRangeValue rangeValue];
        
        BOOL noRangeConflict = (NSIntersectionRange(progressPercentRange, existingRange).length == 0);
        NSAssert(noRangeConflict, @"progressPercentRange sent to -addSnappingProgressPosition:forProgressPercentRange: intersects a progressPercentRange for an existing progressPosition.");
    }];
    
    NSValue *progressPercentRangeValue = [NSValue valueWithRange:progressPercentRange];
    NSNumber *progressPositionValue = [NSNumber numberWithDouble:progress];
    
    [self.progressRanges setObject:progressPositionValue forKey:progressPercentRangeValue];
}

- (void)removeSnappingPositionProgressForStartProgress:(CGFloat)start endProgress:(CGFloat)end {
    // Make sure start and end are between 0 and 1
    start = fmax(fmin(start, 1.0), 0.0) * 100.0;
    end = fmax(fmin(end, 1.0), 0.0) * 100.0;
    NSRange progressPercentRange = NSMakeRange(start, end-start);
    
    NSValue *progressPercentRangeValue = [NSValue valueWithRange:progressPercentRange];
    
    [self.progressRanges removeObjectForKey:progressPercentRangeValue];
}

- (void)snapToProgress:(CGFloat)progress scrollView:(UIScrollView *)scrollView {
    CGFloat deltaProgress = progress - self.animatableNavBar.progress;
    CGFloat deltaYOffset = (self.animatableNavBar.maximumBarHeight-self.animatableNavBar.minimumBarHeight) * deltaProgress;
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+deltaYOffset);
    
    self.animatableNavBar.progress = progress;
    [self.animatableNavBar setNeedsLayout];
    [self.animatableNavBar layoutIfNeeded];
    
    self.currentlySnapping = NO;
}

/**
 *  全部展示
 */
- (void)snapToResetProgress {
    self.animatableNavBar.progress = 0.0;
    [self.animatableNavBar setNeedsLayout];
    [self.animatableNavBar layoutIfNeeded];
    
    self.currentlySnapping = NO;
}

- (void)snapWithScrollView:(UIScrollView *)scrollView {
    if (!self.isCurrentlySnapping && self.isSnappingEnabled && self.animatableNavBar.progress >= 0.0) {
        self.currentlySnapping = YES;
        
        __block CGFloat snapPosition = MAXFLOAT;
        [self.progressRanges enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            NSValue *existingRangeValue = key;
            NSRange existingRange = [existingRangeValue rangeValue];
            
            CGFloat progressPercent = self.animatableNavBar.progress * 100.0;
            
            if (progressPercent >= existingRange.location
                && (progressPercent <= (existingRange.location+existingRange.length))) {
                NSNumber *existingProgressValue = obj;
                snapPosition = [existingProgressValue doubleValue];
            }
            
        }];
        
        if (snapPosition != MAXFLOAT) {
            [UIView animateWithDuration:0.15 animations:^{
                
                [self snapToProgress:snapPosition scrollView:scrollView];
                
            } completion:^(BOOL finished) {
                
                self.currentlySnapping= NO;
                
            }];
        } else {
            self.currentlySnapping= NO;
        }
    }
}


# pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self snapWithScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self snapWithScrollView:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.scrollIndicatorInsets =  UIEdgeInsetsMake(CGRectGetHeight(self.animatableNavBar.bounds), scrollView.scrollIndicatorInsets.left, scrollView.scrollIndicatorInsets.bottom, scrollView.scrollIndicatorInsets.right);
}

@end
