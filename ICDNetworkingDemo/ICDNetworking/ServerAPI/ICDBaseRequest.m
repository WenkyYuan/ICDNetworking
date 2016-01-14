//
//  ICDBaseRequest.m
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDBaseRequest.h"
#import "ICDURLUtils.h"
#import "ICDURLCacheDAO.h"

@implementation ICDBaseRequest

//以下方法由子类覆盖实现：

- (void)doRequestWithCompletion:(ICDServerAPICompletion)completion {
    [ICDServerAPIUtils doRequest:self completion:completion];
}

- (NSString *)requestURI {
    return @"";
}

- (NSString *)requestJson {
    return @"";
}

- (NSString *)requestUrl {
    NSString *url = [ICDURLUtils normalizedURLWithURI:[self requestURI]].absoluteString;
    return url;
}

- (ICDRequestMethod)requestMethod {
    return ICDRequestMethodPOST;
}

- (BOOL)openCache {
    return NO;
}

#pragma mark - publich method
- (ICDServerAPIResponse *)cacheResponse {
    NSString *responseJson = [[ICDURLCacheDAO sharedManager] urlCacheResponseJson];
    return [ICDServerAPIResponse mj_objectWithKeyValues:responseJson];
}

- (void)saveResponseToCacheFile:(ICDServerAPIResponse *)response {
    if (![self openCache]) {
        return;
    }
    NSString *json = [response mj_JSONString];
    [[ICDURLCacheDAO sharedManager] storeUrlCacheResponseJson:json forRequest:self];
}

@end