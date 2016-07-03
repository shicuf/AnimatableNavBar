//
//  BLImageStyleBehavior.m
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import "BLImageStyleBehavior.h"
#import "BLAnimatableNavBar.h"

@implementation BLImageStyleBehavior

# pragma mark - UIScrollViewDelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    
    if (!self.isCurrentlySnapping) {
        CGFloat progress = (scrollView.contentOffset.y+scrollView.contentInset.top) / (self.animatableNavBar.maximumBarHeight-self.animatableNavBar.minimumBarHeight);
        self.animatableNavBar.progress = progress;
        [self.animatableNavBar setNeedsLayout];
    }
}

@end
