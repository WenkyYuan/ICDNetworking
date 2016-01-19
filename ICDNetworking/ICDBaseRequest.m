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

- (NSTimeInterval)cacheValidTime {
    return 60;
}

#pragma mark - publich method
- (void)doRequestWithCompletion:(ICDServerAPICompletion)completion {
    self.dataTask = [ICDServerAPIUtils doRequest:self completion:completion];
    self.completionBlock = completion;
}

- (ICDServerAPIResponse *)cacheResponse {
    NSString *responseJson = [[ICDURLCacheDAO sharedManager] urlCacheResponseJsonForRequest:self];
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
