//
//  ICDServerAPIUtils.m
//  rank
//
//  Created by wenky on 15/12/29.
//  Copyright © 2015年 wenky. All rights reserved.
//

#import "ICDServerAPIUtils.h"
#import "ICDDeviceUtils.h"
#import "ICDBaseRequest.h"

#import "ICDAPPConstants.h"
#import "ICDNotificationConstants.h"

#import <AFNetworking/AFNetworking.h>
#import <UIDevice-Hardware/UIDevice-Hardware.h>

@implementation ICDServerAPIUtils

+ (NSURLSessionDataTask *)doRequest:(id)request completion:(ICDServerAPICompletion)completion {
    if (![request isKindOfClass:[ICDBaseRequest class]]) {
        NSLog(@"request must be ICDBaseRequest class!");
        return nil;
    }
    ICDBaseRequest *rq = (ICDBaseRequest *)request;
    NSString *json = rq.requestJson;
    NSURL *url = [NSURL URLWithString:rq.requestUrl];
    //TODO:判断requestMethod
    return [self sendJSON:json toURL:url request:rq completion:completion];
}

+ (NSURLSessionDataTask *)sendJSON:(NSString *)json toURL:(NSURL *)url completion:(ICDServerAPICompletion)completion {
    return [self sendJSON:json toURL:url request:nil completion:completion];
}

+ (NSURLSessionDataTask *)sendJSON:(NSString *)json toURL:(NSURL *)url request:(ICDBaseRequest *)request completion:(ICDServerAPICompletion)completion {
    NSMutableURLRequest *mutableURLReq = [NSMutableURLRequest requestWithURL:url];
    [mutableURLReq setHTTPMethod:@"POST"];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    [mutableURLReq setHTTPBody:data];
    // http headers
    [mutableURLReq setAllHTTPHeaderFields:@{@"User-Agent": [self userAgent],
                                            @"Content-Type": @"application/json",
                                            @"Content-Length": [@(data.length) stringValue],
                                            @"FA": [ICDDeviceUtils idfaString],
                                            @"FV": [ICDDeviceUtils idfvString]
                                            }];
    AFHTTPSessionManager *manager = [self jsonSesionManager];
    NSLog(@"server request: %@, data: %@", url.absoluteString, json);
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:mutableURLReq completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        ICDServerAPIResponse *rsponse = nil;
        if (error) {
            rsponse = [ICDServerAPIResponse responseForNetworkErrorWithMessage:error.description];
        } else if (![responseObject isKindOfClass:[NSDictionary class]]) {
            rsponse  = [ICDServerAPIResponse responseForMalformedResponseErrorWithMessage:nil];
        } else {
            rsponse = [ICDServerAPIResponse mj_objectWithKeyValues:responseObject];
        }
        if (!rsponse) {
            rsponse  = [ICDServerAPIResponse responseForMalformedResponseErrorWithMessage:nil];
        }
        if (!rsponse.success) {
            [self notifyAPIErrorOccurredWithParameters:json url:url response:rsponse error:[rsponse error]];
        }
        if (request) {
            [request saveResponseToCacheFile:rsponse];
        }
        if (completion) {
            NSLog(@"%@, server response: %@", url, rsponse.data);
            completion(rsponse);
        }
    }];
    [dataTask resume];
    return dataTask;
}

+ (void)cancelAllRequests {
    [[self jsonSesionManager].dataTasks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        NSURLSessionDataTask *task = obj;
        [task cancel];
    }];
    [[self uploadSessionManager].dataTasks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSURLSessionDataTask *task = obj;
        [task cancel];
    }];
}

+ (void)notifyAPIErrorOccurredWithParameters:(id)params url:(NSURL *)url response:(ICDServerAPIResponse *)response error:(NSError *)error{
    NSMutableDictionary *userInfo = [@{} mutableCopy];
    if (params) {
        userInfo[@"parameters"] = params;
    }
    if (url) {
        userInfo[@"url"] = url;
    }
    if (response) {
        userInfo[@"response"] = response;
    }
    if (error) {
        userInfo[@"error"] = error;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kICDNotificationServerAPIErrorOccurred object:self userInfo:[userInfo copy]];
}

+ (NSString *)userAgent {
    UIDevice *device = [UIDevice currentDevice];
    //TODO:replace format
    return [NSString stringWithFormat:@"%@, iOS %@, version %@", device.modelName, device.systemVersion, kAppVersion];
}

+ (AFHTTPSessionManager *)jsonSesionManager {
    static AFHTTPSessionManager *jsonSesionManager = nil;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        jsonSesionManager = [AFHTTPSessionManager manager];
        jsonSesionManager.operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount; //并发数Max
    });
    return jsonSesionManager;
}

+ (AFHTTPSessionManager *)uploadSessionManager {
    static AFHTTPSessionManager *uploadSessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uploadSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        uploadSessionManager.operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
        uploadSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return uploadSessionManager;
}

@end
