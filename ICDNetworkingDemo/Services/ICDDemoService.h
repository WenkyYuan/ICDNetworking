//
//  ICDDemoService.h
//  rank
//
//  Created by wenky on 16/1/11.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICDBaseService.h"

typedef void(^QuerySocialTopicsCompletionBlock)(NSArray *topics, NSError *error);

@interface ICDDemoService : ICDBaseService

+ (instancetype)sharedManager;

- (void)queryTopicsByScope:(NSUInteger)scope offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(QuerySocialTopicsCompletionBlock)completion;

- (void)queryTopicsByScope:(NSUInteger)scope offset:(NSUInteger)offset limit:(NSUInteger)limit ignoreCache:(BOOL)ignoreCache completion:(QuerySocialTopicsCompletionBlock)completion;

@end
