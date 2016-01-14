//
//  UIView+TLLayout.m
//  rank
//
//  Created by wenky on 16/1/13.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "UIView+TLLayout.h"
#import <objc/runtime.h>
#import "NSArray+EnumeratingExtras.h"


static void *kTLHiddenConstraintsKey = &kTLHiddenConstraintsKey;

@implementation UIView (TLLayout)

@dynamic hiddenConstraints;

- (NSArray *)hiddenConstraints {
    return objc_getAssociatedObject(self, &kTLHiddenConstraintsKey);
}

- (void)setHiddenConstraints:(NSArray *)constraints {
    objc_setAssociatedObject(self, &kTLHiddenConstraintsKey, constraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hideAndRemoveConstraints {
    self.hidden = YES;
    if (!self.hiddenConstraints) {
        self.hiddenConstraints = [self.superview.constraints objectsPassingTest:^BOOL(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
            return constraint.firstItem == self || constraint.secondItem == self;
        }];
        [self.superview removeConstraints:self.hiddenConstraints];
    }
}

- (void)showAndRestoreConstraints {
    if (self.hiddenConstraints) {
        [self.superview addConstraints:self.hiddenConstraints];
        self.hiddenConstraints = nil;
    }
    self.hidden = NO;
}

@end
