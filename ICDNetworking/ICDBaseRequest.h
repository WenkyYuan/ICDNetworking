//
//  ICDBaseRequest.h
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICDServerAPIUtils.h"

typedef NS_ENUM(NSUInteger, ICDRequestMethod) {
    ICDRequestMethodPOST,
    ICDRequestMethodGET,
};

@interface ICDBaseRequest : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, copy) ICDServerAPICompletion completionBlock;

//开始请求网络
- (void)doRequestWithCompletion:(ICDServerAPICompletion)completion;

//返回当前URL缓存对象
- (ICDServerAPIResponse *)cacheResponse ;

//把URL回调数据存储到缓存文件中
- (void)saveResponseToCacheFile:(ICDServerAPIResponse *)response;

//*****************************************************************

//以下方法由子类继承来覆盖默认值：

// --- @required --- //

//请求的URI
- (NSString *)requestURI;

//请求的参数JSON
- (NSString *)requestJson;

// --- @optional --- //

//请求的Url,默认为ICDServiceBaseUrl＋requestURI＋必要url参数
- (NSString *)requestUrl;

//请求Method,默认为POST
- (ICDRequestMethod)requestMethod;

//是否开启URL缓存,默认为NO不开启
- (BOOL)openCache;

@end
