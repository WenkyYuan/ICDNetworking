//
//  ICDErrorUtils.m
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDErrorUtils.h"
#import "ICDServerAPIConstants.h"

@implementation ICDErrorUtils

+ (NSString *)errorTips:(NSError *)error {
    NSString *errorMessage = error.userInfo[kErrorUserInfoErrorMessageKey];
    if (errorMessage.length == 0) {
        errorMessage = @"未知错误";
    }
    return errorMessage;
}

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code message:(NSString *)msg {
    if (!msg) {
        msg = @"";
    }
    return [NSError errorWithDomain:domain code:code userInfo:@{kErrorUserInfoErrorMessageKey: msg}];
}

+ (BOOL)isNotLoggedInError:(NSError *)error {
    if ([error.domain isEqualToString:kErrorDomainServerAPIBusinessError]
        && error.code == kICDServerAPICodeNotLoggedIn) {
        return YES;
    }
    return NO;
}

@end
