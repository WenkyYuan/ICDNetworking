//
//  ICDDeviceUtils.h
//  rank
//
//  Created by wenky on 16/1/4.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICDDeviceUtils : NSObject

+ (NSString *)macString;
+ (NSString *)idfaString;//广告标示符（IDFA-identifierForIdentifier）
+ (NSString *)idfvString;//Vindor标示符 (IDFV-identifierForVendor)

+ (BOOL)hasCellularCoverage; //是否有移动蜂窝覆盖

@end
