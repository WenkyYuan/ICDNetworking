//
//  ICDErrorUtils.h
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICDErrorConstants.h"

@interface ICDErrorUtils : NSObject

+ (NSString *)errorTips:(NSError *)error;

+ (NSError *)errorWithDomain:(NSString *)domain code:(NSInteger)code message:(NSString *)msg;

+ (BOOL)isNotLoggedInError:(NSError *)error;

@end
