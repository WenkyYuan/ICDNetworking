//
//  NSDate+Extras.h
//  rank
//
//  Created by wenky on 16/1/4.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extras)

+ (instancetype)today;

+ (instancetype)oneSecondBeforeTomorrow;

+ (instancetype)tomorrow;

+ (instancetype)yesterday;

+ (instancetype)fromTimeStamp:(long long)timestamp;

+ (instancetype)fromString:(NSString *)string format:(NSString *)format;

- (long long)toTimeStampInMilliseconds;

- (NSString *)toFormattedString:(NSString *)format;

- (BOOL)isBetweenFrontDate:(NSDate *)frontDate behindDate:(NSDate *)behindDate;

@end
