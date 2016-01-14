//
//  ICDDemoService.m
//  rank
//
//  Created by wenky on 16/1/11.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDDemoService.h"
#import "ICDDemoAPI.h"
#import "SocialTopic.h"

@implementation ICDDemoService

+ (void)queryTopicsByScope:(NSUInteger)scope offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(QuerySocialTopicsCompletionBlock)completion {
    [self queryTopicsByScope:scope offset:offset limit:limit ignoreCache:NO completion:completion];
}

+ (void)queryTopicsByScope:(NSUInteger)scope offset:(NSUInteger)offset limit:(NSUInteger)limit ignoreCache:(BOOL)ignoreCache completion:(QuerySocialTopicsCompletionBlock)completion {
    
    ICDDemoAPI *api = [[ICDDemoAPI alloc] initWithScope:scope offset:offset limit:limit];
    
    void (^convertDataToModelBlock)(ICDServerAPIResponse *) = ^(ICDServerAPIResponse *response) {
        NSArray *topics;
        if (response.success) {
            topics = [SocialTopic mj_objectArrayWithKeyValuesArray:response.data[@"topics"]];
        }
        if (completion) {
            completion(topics, response.error);
        }
    };
    
    
    if (!ignoreCache && api.cacheResponse) {
        //先从缓存中读取一次数据，再从网络请求一次
        convertDataToModelBlock(api.cacheResponse);
    }
    
    [api doRequestWithCompletion:convertDataToModelBlock];
}

@end
