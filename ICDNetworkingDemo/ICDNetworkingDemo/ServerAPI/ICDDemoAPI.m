//
//  ICDDemoAPI.m
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDDemoAPI.h"

@interface ICDDemoAPI ()
@property (nonatomic, assign) NSUInteger offset;
@property (nonatomic, assign) NSUInteger limit;
@property (nonatomic, assign) NSUInteger scope;

@end

@implementation ICDDemoAPI

- (instancetype)initWithScope:(NSUInteger)scope offset:(NSUInteger)offset limit:(NSUInteger)limit {
    self = [super init];
    if (self) {
        _offset = offset;
        _limit = limit;
        _scope = scope;
    }
    return self;
}

- (NSString *)requestURI {
    return @"/user/api/social/listTopicByScopeWithPaging.do";
}

- (NSString *)requestJson {
    NSDictionary *dict = @{@"offset":@(self.offset),
                           @"limit":@(self.limit),
                           @"scope":@(self.scope),};
    NSString *json = [dict mj_JSONString];
    return json;
}

- (BOOL)openCache {
    return YES;
}

@end
