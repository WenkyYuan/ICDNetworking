//
//  ICDServerAPIUtils.h
//  rank
//
//  Created by wenky on 15/12/29.
//  Copyright © 2015年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICDServerAPIResponse.h"

typedef void(^ICDServerAPICompletion)(ICDServerAPIResponse *response);

@interface ICDServerAPIUtils : NSObject

//request:$ICDBaseRequest
+ (NSURLSessionDataTask *)doRequest:(id)request completion:(ICDServerAPICompletion)completion;

+ (NSURLSessionDataTask *)sendJSON:(NSString *)json toURL:(NSURL *)url completion:(ICDServerAPICompletion)completion;

+ (void)cancelAllRequests;

@end
