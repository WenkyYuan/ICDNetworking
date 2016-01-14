//
//  ICDDemoAPI.h
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDBaseRequest.h"

@interface ICDDemoAPI : ICDBaseRequest

- (instancetype)initWithScope:(NSUInteger)scope offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end
