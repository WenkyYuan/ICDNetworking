//
//  ICDKVStorage.h
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVItem : NSObject
@property (nonatomic, copy) NSString *value;
@property (nonatomic, strong) NSDate *updatedTime;

@end

@interface ICDKVStorage : NSObject

+ (instancetype)sharedInstance;

- (BOOL)putStringValue:(NSString *)value forKey:(NSString *)key;
- (BOOL)putStringValue:(NSString *)value forKey:(NSString *)key withDomain:(NSString *)domain;

- (BOOL)deleteStringValueForKey:(NSString *)key;
- (BOOL)deleteStringValueForKey:(NSString *)key withDomain:(NSString *)domain;

- (NSString *)stringValueForKey:(NSString *)key;
- (NSString *)stringValueForKey:(NSString *)key withDomain:(NSString *)domain;

- (KVItem *)itemForKey:(NSString *)key;
- (KVItem *)itemForKey:(NSString *)key withDomain:(NSString *)domain;

@end
