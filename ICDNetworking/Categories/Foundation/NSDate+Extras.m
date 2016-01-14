//
//  NSDate+Extras.m
//  rank
//
//  Created by wenky on 16/1/4.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "NSDate+Extras.h"

@implementation NSDate (Extras)

+ (instancetype)today {
    NSDate *now = [NSDate date];
    NSString *dateStr = [now toFormattedString:@"yyyy-MM-dd"];
    NSDate *today = [NSDate fromString:dateStr format:@"yyyy-MM-dd"];
    return today;
}

+ (instancetype)oneSecondBeforeTomorrow {
    return [NSDate dateWithTimeInterval:(86400-1) sinceDate:[self today]];
}

+ (instancetype)tomorrow {
    return [NSDate dateWithTimeInterval:86400 sinceDate:[self today]];
}

+ (instancetype)yesterday {
    return [NSDate dateWithTimeInterval:-86400 sinceDate:[self today]];
}

+ (instancetype)fromTimeStamp:(long long)timestamp {
    if(timestamp > 140000000000) {
        timestamp = timestamp / 1000;
    }
    NSTimeInterval value = timestamp;
    return [[NSDate alloc] initWithTimeIntervalSince1970:value];
}

+ (instancetype)fromString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

- (long long)toTimeStampInMilliseconds {
    NSTimeInterval timeInMills = [self timeIntervalSince1970] * 1000;
    return [@(timeInMills) longLongValue];
}

- (NSString *)toFormattedString:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (BOOL)isBetweenFrontDate:(NSDate *)frontDate behindDate:(NSDate *)behindDate {
    if ([[self laterDate:frontDate] isEqualToDate:self]
        && [[self laterDate:behindDate] isEqualToDate:behindDate]) {
        return YES;
    }
    return NO;
}

@end
