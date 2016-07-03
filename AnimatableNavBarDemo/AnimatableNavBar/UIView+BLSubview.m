//
//  UIView+BLSubview.m
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import "UIView+BLSubview.h"

#import <objc/runtime.h>

@interface UIView (_BLSubview)

@property (nonatomic) NSMutableArray *progresses;
@property (nonatomic) NSMutableArray *layoutAttributesForProgresses;

@end

@implementation UIView (BLSubview)

- (NSMutableArray *)progresses {
    return (NSMutableArray *)objc_getAssociatedObject(self, @selector(progresses));
}

- (void)setProgresses:(NSMutableArray *)progresses {
    objc_setAssociatedObject(self, @selector(progresses), progresses, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)layoutAttributesForProgresses {
    return (NSMutableArray *)objc_getAssociatedObject(self, @selector(layoutAttributesForProgresses));
}

- (void)setLayoutAttributesForProgresses:(NSMutableArray *)layoutAttributesForProgresses {
    objc_setAssociatedObject(self, @selector(layoutAttributesForProgresses), layoutAttributesForProgresses, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


# pragma mark - Add and remove layout attributes

- (void)addLayoutAttributes:(BLSubviewLayoutAttributes *)layoutAttributes forProgress:(CGFloat)progress {
    // Lazily init arrays
    if (!self.progresses) {
        self.progresses = [[NSMutableArray alloc] init];
    }
    
    if (!self.layoutAttributesForProgresses) {
        self.layoutAttributesForProgresses = [[NSMutableArray alloc] init];
    }
    
    // Make sure the progressPosition is between 0 and 1
    progress = fmax(fmin(progress, 1.0), 0.0);
    
    // If layout attributes for this progressPosition already exists, just replace it
    [self.progresses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSNumber *existingDoubleValue = obj;
        CGFloat existingDouble = [existingDoubleValue doubleValue];
        
        if(existingDouble == progress) {
            [self.layoutAttributesForProgresses replaceObjectAtIndex:idx withObject:layoutAttributes];
            return;
        }
    }];
    
    // Insert element at correct position so that it stays sorted
    __block NSUInteger insertionIndex = 0;
    [self.progresses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSNumber *existingDoubleValue = obj;
        CGFloat existingDouble = [existingDoubleValue doubleValue];
        
        if (progress > existingDouble) {
            insertionIndex++;
        } else {
            *stop = YES;
        }
    }];
    
    [self.progresses insertObject:[NSNumber numberWithDouble:progress] atIndex:insertionIndex];
    [self.layoutAttributesForProgresses insertObject:layoutAttributes atIndex:insertionIndex];
}

- (void)removeLayoutAttributesForProgress:(CGFloat)progress {
    NSInteger indexToRemove = [self.progresses indexOfObject:[NSNumber numberWithDouble:progress]];
    
    if (indexToRemove != NSNotFound) {
        [self.progresses removeObjectAtIndex:indexToRemove];
        [self.layoutAttributesForProgresses removeObjectAtIndex:indexToRemove];
    }
}


# pragma mark - Public Method

- (NSUInteger)numberOfLayoutAttributes {
    return self.layoutAttributesForProgresses.count;
}

- (CGFloat)progressAtIndex:(NSUInteger)index {
    NSNumber *progressValue = [self.progresses objectAtIndex:index];
    return [progressValue doubleValue];
}

- (BLSubviewLayoutAttributes *)layoutAttributesAtIndex:(NSUInteger)index {
    return [self.layoutAttributesForProgresses objectAtIndex:index];
}

@end
