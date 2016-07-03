//
//  BLSplitterDelegate.m
//  AnimatableNavBar
//
//  Created by shicuf on 16/7/3.
//  Copyright © 2016年 Belle. All rights reserved.
//

#import "BLSplitterDelegate.h"

@implementation BLSplitterDelegate

#pragma mark - init
- (instancetype)initWithAdditionalDelegate:(id<NSObject>)additionalDelegate originalDelegate:(id<NSObject>)originalDelegate {
    if (self = [super init]) {
        _originalDelegate = originalDelegate;
        _additionalDelegate = additionalDelegate;
    }
    
    return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = [anInvocation selector];
    
    if ([self.additionalDelegate respondsToSelector:aSelector]) {
        [anInvocation invokeWithTarget:self.additionalDelegate];
    }
    
    if ([self.originalDelegate respondsToSelector:aSelector]) {
        [anInvocation invokeWithTarget:self.originalDelegate];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *additional = [(NSObject *)self.additionalDelegate methodSignatureForSelector:aSelector];
    NSMethodSignature *original = [(NSObject *)self.originalDelegate methodSignatureForSelector:aSelector];
    
    if (additional) {
        return additional;
    } else if (original) {
        return original;
    }
    
    return nil;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.additionalDelegate respondsToSelector:aSelector]
        || [self.originalDelegate respondsToSelector:aSelector]) {
        return YES;
    } else {
        return NO;
    }
}

@end
