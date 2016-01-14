//
//  ICDServerAPIResponse.h
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICDServerAPIResponse : NSObject
@property (nonatomic, assign, readonly) NSInteger code;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, strong, readonly) id data;
@property (nonatomic, copy, readonly) NSString *sid;
@property (nonatomic, assign, readonly) BOOL success;

- (instancetype)initWithDictionary:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;

@end

@interface ICDServerAPIResponse (Error)

- (NSString *)errorMessage;
- (NSError *)error;

+ (instancetype)responseForNetworkErrorWithMessage:(NSString *)message;
+ (instancetype)responseForMalformedResponseErrorWithMessage:(NSString *)message;

@end
