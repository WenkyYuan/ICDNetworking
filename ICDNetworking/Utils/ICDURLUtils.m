//
//  ICDURLUtils.m
//  rank
//
//  Created by wenky on 16/1/4.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDURLUtils.h"
#import "ICDServerAPIConstants.h"
#import "ICDDeviceUtils.h"
#import "ICDAPPConstants.h"
#import "ICDStringUtils.h"
#import <NSURL+QueryDictionary/NSURL+QueryDictionary.h>

@implementation ICDURLUtils

+ (NSURL *)normalizedURLWithURI:(NSString *)uri {
    if (!uri) {
        return nil;
    }
    NSString *urlStr;
    if ([uri hasPrefix:@"http://"] || [uri hasPrefix:@"https://"]) {
        urlStr = uri;
    } else {
        urlStr = [NSString stringWithFormat:@"%@%@", kICDServerBaseURL, uri];
    }
    
    //TODO:sid
    NSString *sid = @"ae883e5d6f184e22afa3752a38aafa53";
    NSString *idfa = [ICDDeviceUtils idfaString];
    idfa = [ICDStringUtils trimToEmpty:idfa];
    NSString *appVersion = [NSString stringWithFormat:@"iOS_%@", kAppVersion];
    NSURL *url = [NSURL URLWithString:urlStr];
    url = [url uq_URLByAppendingQueryDictionary:@{@"sid":sid,
                                                  @"ver":appVersion,
                                                  @"imei":idfa}];
    return url;
}

@end
