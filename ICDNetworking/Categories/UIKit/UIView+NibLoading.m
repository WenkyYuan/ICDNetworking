//
//  UIView+NibLoading.m
//  rank
//
//  Created by wenky on 16/1/13.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "UIView+NibLoading.h"

@implementation UIView (NibLoading)

+ (instancetype)loadInstanceFromNib {
    UIView *result = nil;
    NSArray* elements = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    for (id obj in elements) {
        if ([obj isKindOfClass:[self class]]) {
            result = obj;
            break;
        }
    }
    return result;
}

@end
