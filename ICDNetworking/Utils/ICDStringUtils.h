//
//  ICDStringUtils.h
//  rank
//
//  Created by wenky on 16/1/4.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ICDStringUtils : NSObject
// X 分钟前; X 小时前; X 天前
+ (NSString *)toTimeIntervalString:(NSDate *)dateTime;

// HH:mm; 昨天HH:mm; 前天HH:mm; MM-dd; yyyy-MM-dd
+ (NSString *)toTimeString:(NSDate *)dateTime;

+ (NSString *)toDurationString:(long)durationInMills;

+ (NSString *)toDistanceString:(CLLocationDistance)distanceInMeters;

+ (NSString *)toCountString:(NSInteger)count maxValue:(NSInteger)maxVal;

+ (NSString *)toAreaStringWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district;

+ (NSString *)toAreaStringWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district containsDot:(BOOL)containsDot;

+ (NSString *)stringOrNil:(id)obj;

+ (NSString *)trimToEmpty:(NSString *)str;

+ (NSString *)urlencode:(NSString *)str;

+ (NSString *)stringByDeleteAllNonDigitalChar:(NSString *)str;

+ (NSString *)idCardString:(NSString *)str;

+ (BOOL)isPhoneNum:(NSString *)str;

+ (BOOL)isEmail:(NSString *)str;

+ (void)addDoNotBackupAttribute:(NSString *)path;//path对应文件夹添加属性“不备份（iTunes或iCloud中）”

+ (NSString *)md5StringFromString:(NSString *)string;

@end
