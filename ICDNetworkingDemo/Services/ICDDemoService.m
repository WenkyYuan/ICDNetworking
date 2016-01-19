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

+ (instancetype)sharedManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initPrivate];
    });
    return instance;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"IllegalAccessExcetpion" reason:@"Use `+ (instancetype)sharedManager` instead" userInfo:nil];
}

- (instancetype)initPrivate {
    self = [super init];
    return self;
}

- (void)queryTopicsByScope:(NSUInteger)scope offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(QuerySocialTopicsCompletionBlock)completion {
    return  [self queryTopicsByScope:scope offset:offset limit:limit ignoreCache:NO completion:completion];
}

- (void)queryTopicsByScope:(NSUInteger)scope offset:(NSUInteger)offset limit:(NSUInteger)limit ignoreCache:(BOOL)ignoreCache completion:(QuerySocialTopicsCompletionBlock)completion {
    
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
        [api doRequestWithCompletion:nil];
    } else {
        [api doRequestWithCompletion:convertDataToModelBlock];
    }
    [self.allServices addObject:api.dataTask];
}

@end
