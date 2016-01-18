//
//  ICDBaseService.m
//  rank
//
//  Created by wenky on 16/1/18.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDBaseService.h"

@interface ICDBaseService ()
@property (nonatomic, strong) NSMutableArray *allServices;
@end

@implementation ICDBaseService

- (void)removeAllServices {
    [self.allServices enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURLSessionDataTask *task = (NSURLSessionDataTask *)obj;
        [task cancel];
    }];
    [self.allServices removeAllObjects];
}

- (NSMutableArray *)allServices {
    if (!_allServices) {
        _allServices = [[NSMutableArray alloc] init];
    }
    return _allServices;
}

@end
