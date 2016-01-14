//
//  NSArray+EnumeratingExtras.m
//  rank
//
//  Created by wenky on 16/1/13.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "NSArray+EnumeratingExtras.h"

@implementation NSArray (EnumeratingExtras)

- (NSArray *)objectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:predicate]];
}

@end
