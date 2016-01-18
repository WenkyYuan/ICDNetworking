//
//  ICDBaseService.h
//  rank
//
//  Created by wenky on 16/1/18.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICDBaseService : NSObject

@property (nonatomic, readonly, strong) NSMutableArray *allServices;

- (void)removeAllServices;

@end
