//
//  NSString+Trim.m
//  rank
//
//  Created by wenky on 16/1/4.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
