//
//  ICDStringUtils.m
//  rank
//
//  Created by wenky on 16/1/4.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDStringUtils.h"
#import "NSDate+Extras.h"
#import "NSString+Trim.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ICDStringUtils
+ (NSString *)toTimeIntervalString:(NSDate *)dateTime {
    NSInteger timeInterval = -[@([dateTime timeIntervalSinceNow]) integerValue];
    if (timeInterval < 60) {
        return @"1分钟前";
    } else if (timeInterval < 3600) { // 1小时内
        return [NSString stringWithFormat:@"%ld分钟前", (long)timeInterval / 60];
    } else if (timeInterval < 86400) { // 24小时内
        return [NSString stringWithFormat:@"%ld小时前", (long)timeInterval / 3600];
    } else { // x天以前
        long dayTimeInterval = (long)timeInterval / 86400;
        return [NSString stringWithFormat:@"%ld天前", dayTimeInterval];
    }
}

+ (NSString *)toTimeString:(NSDate *)dateTime {
    NSTimeInterval timeInterval = [dateTime timeIntervalSince1970];
    
    NSString *todayDateStr = [[NSDate date] toFormattedString:@"yyyy-MM-dd"];
    NSTimeInterval todayInterval = [[NSDate fromString:todayDateStr format:@"yyyy-MM-dd"] timeIntervalSince1970];
    
    NSDate *yearDate = [NSDate fromString:[NSString stringWithFormat:@"%@-01-01", [todayDateStr substringToIndex:4]] format:@"yyyy-MM-dd"];
    NSTimeInterval yearInterval = [yearDate timeIntervalSince1970];
    
    if (timeInterval >= todayInterval) {
        // 今天00:00以后的时间，只显示小时和分钟
        return [dateTime toFormattedString:@"HH:mm"];
    } else if (todayInterval - timeInterval <= 86400) {
        // 昨天的时间
        return [dateTime toFormattedString:@"昨天HH:mm"];
    } else if (todayInterval - timeInterval <= 86400*2) {
        // 前天的时间
        return [dateTime toFormattedString:@"前天HH:mm"];
    } else if (timeInterval >= yearInterval) {
        // 今年内的时间
        return [dateTime toFormattedString:@"MM-dd"];
    } else {
        return [dateTime toFormattedString:@"yyyy-MM-dd"];
    }
}

+ (NSString *)toDurationString:(long)durationInMills {
    long durationInSeconds = durationInMills/1000;
    
    if (durationInSeconds < 60) {
        return [NSString stringWithFormat:@"%ld", durationInSeconds];
    } else if (durationInSeconds <3600) {
        return [NSString stringWithFormat:@"%ld:%ld", durationInSeconds/60, durationInSeconds%60];
    } else {
        return [NSString stringWithFormat:@"%ld:%ld:%ld", durationInSeconds/3600, (durationInSeconds%3600)/60, (durationInSeconds%3600)%60];
    }
}

+ (NSString *)toDistanceString:(CLLocationDistance)distanceInMeters {
    if (distanceInMeters <= 0) {
        distanceInMeters = 1;
    }
    
    double distanceInKilometers = ((double)distanceInMeters) / 1000.0;
    if (distanceInMeters < 100000) {
        return [NSString stringWithFormat:@"%.2fkm", distanceInKilometers];
    }
    
    return [NSString stringWithFormat:@"%ldkm", (long)[@(distanceInKilometers) integerValue]];
}

+ (NSString *)toCountString:(NSInteger)count maxValue:(NSInteger)maxVal {
    if (count < 0) {
        count = 0;
    }
    if (count > maxVal) {
        return [NSString stringWithFormat:@"%ld+", (long)maxVal];
    }
    return [@(count) stringValue];
}

+ (NSString *)toAreaStringWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district {
    return [self toAreaStringWithProvince:province city:city district:district containsDot:YES];
}

+ (NSString *)toAreaStringWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district containsDot:(BOOL)containsDot {
    NSArray *citiesToHidden = @[@"省直辖", @"市辖区", @"县"];
    
    NSMutableString *mutableStr = [[NSMutableString alloc] init];
    if (province.length > 0) {
        [mutableStr appendString:province];
        if (containsDot) {
            [mutableStr appendString:@" · "];
        }
    }
    if (city.length > 0 && ![citiesToHidden containsObject:city]) {
        [mutableStr appendString:city];
        if (containsDot) {
            [mutableStr appendString:@" · "];
        }
    }
    if (district.length > 0) {
        [mutableStr appendString:district];
        if (containsDot) {
            [mutableStr appendString:@" · "];
        }
    }
    if (mutableStr.length == 0) {
        return @"";
    }
    if (containsDot) {
        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length - 3, 3)];
    }
    
    return [mutableStr copy];
}

+ (NSString *)toAgeString:(NSInteger)age {
    static NSInteger maxAge = 999;
    if (age < 0) {
        return @"";
    }
    if (age > maxAge) {
        return [NSString stringWithFormat:@"%ld+", (long)maxAge];
    }
    return [@(age) stringValue];
}

+ (NSString *)stringOrNil:(id)obj {
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    return nil;
}

+ (NSString *)trimToEmpty:(NSString *)str {
    if (![str isKindOfClass:[NSString class]]) {
        return @"";
    }
    if (str.length == 0) {
        return @"";
    }
    return [str trim];
}

+ (NSString *)urlencode:(NSString *)str {
    if (str.length == 0) {
        return @"";
    }
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)stringByDeleteAllNonDigitalChar:(NSString *)str {
    if (str.length == 0) {
        return @"";
    }
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"[^\\d]"
                                  options:NSRegularExpressionCaseInsensitive error:&error];
    return [regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
}

+ (NSString *)idCardString:(NSString *)str {
    NSUInteger maskOffset = 6;
    if (str.length <= maskOffset) {
        return str;
    }
    
    NSUInteger maskLength = str.length - maskOffset;
    NSMutableString *stars = [NSMutableString string];
    for (NSUInteger i = 0; i < maskLength; ++i) {
        [stars appendString:@"*"];
    }
    
    NSString *result = [str stringByReplacingCharactersInRange:NSMakeRange(maskOffset, maskLength) withString:[stars copy]];
    return result;
}

+ (BOOL)isPhoneNum:(NSString *)str {
    if (str.length != 11) {
        return NO;
    }
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^1[34578][0-9]{9}$" options:0 error:nil];
    NSRange range = [regex rangeOfFirstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    return range.location != NSNotFound;
}

+ (BOOL)isEmail:(NSString *)str {
    // Note: Some email provider may violate the standard, so here we only
    // check that
    // address consists of two part that are separated by '@', and domain
    // part contains
    // at least one '.'.
    
    // x@x.x --> length: 5
    if (str.length < 5) {
        return NO;
    }
    
    NSRange firstAt = [str rangeOfString:@"@"];
    if (firstAt.location == NSNotFound || firstAt.location <= 0 || firstAt.location == str.length-1) {
        return NO;
    }
    
    NSRange lastAt = [str rangeOfString:@"@" options:NSBackwardsSearch];
    if (firstAt.location != lastAt.location) {
        return NO;
    }
    
    NSRange domainFirstDot = [str rangeOfString:@"." options:0 range:NSMakeRange(lastAt.location, str.length - lastAt.location)];
    if (domainFirstDot.location == NSNotFound) {
        return NO;
    }
    
    NSRange lastDot = [str rangeOfString:@"." options:NSBackwardsSearch];
    if (lastDot.location == str.length - 1) {
        return NO;
    }
    
    return YES;
}

+ (void)addDoNotBackupAttribute:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        NSLog(@"error to set do not backup attribute, error = %@", error);
    }
}

+ (NSString *)md5StringFromString:(NSString *)string {
    if(string == nil || [string length] == 0)
        return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

@end
