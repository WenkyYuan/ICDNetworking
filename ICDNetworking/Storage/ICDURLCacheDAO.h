//
//  ICDURLCacheDAO.h
//  rank
//
//  Created by wenky on 16/1/11.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ICDServerAPIResponse;
@class ICDBaseRequest;

@interface ICDURLCacheDAO : NSObject

+ (instancetype)sharedManager;

- (NSString *)urlCacheResponseJson;

- (void)storeUrlCacheResponseJson:(NSString *)responseJson forRequest:(ICDBaseRequest *)request;

@end