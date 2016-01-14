//
//  ICDKVStorage.m
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDKVStorage.h"
#import <FMDB.h>

#define PATH_OF_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

static NSString *const DB_NAME = @"ICDKVStorage.db";
static NSString *const TABLE_NAME = @"KVSTORAGE";
static NSString *const DEFAULT_DOMAIN = @"COMMON_DOMAIN";

static NSString *const CREATE_TABLE_SQL =
@"CREATE TABLE IF NOT EXISTS %@ ( \
domain TEXT NOT NULL, \
key TEXT NOT NULL, \
value TEXT NOT NULL, \
updatedTime TEXT NOT NULL, \
UNIQUE (domain, key) \
)";

static NSString *const UPDATE_SQL = @"REPLACE INTO %@ (domain, key, value, updatedTime) VALUES (?, ?, ?, ?)";
static NSString *const QUERY_SQL = @"SELECT value, updatedTime FROM %@ WHERE domain = ? AND key = ? LIMIT 1";
static NSString *const DELETE_SQL = @"DELETE FROM %@ WHERE domain = ? AND key = ?";

@interface ICDKVStorage ()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation ICDKVStorage

- (void)dealloc {
    [_dbQueue close];
}

+ (instancetype)sharedInstance {
    static ICDKVStorage *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] initPrivate];
    });
    return instance;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"IllegalAccessExcetpion" reason:@"Use `+ (instancetype)sharedInstance` instead" userInfo:nil];
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        NSString *dbPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:DB_NAME];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        BOOL success = [self createTable];
        NSAssert(success, @"open table fail");
    }
    return self;
}

- (BOOL)putStringValue:(NSString *)value forKey:(NSString *)key {
    return [self putStringValue:value forKey:key withDomain:DEFAULT_DOMAIN];
}

- (BOOL)putStringValue:(NSString *)value forKey:(NSString *)key withDomain:(NSString *)domain {
    NSDate *updatedTime = [NSDate date];
    NSString *sql = [NSString stringWithFormat:UPDATE_SQL, TABLE_NAME];
    __block BOOL success;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:sql, domain, key, value, updatedTime];
    }];
    return success;
}

- (BOOL)deleteStringValueForKey:(NSString *)key {
    return [self deleteStringValueForKey:key withDomain:DEFAULT_DOMAIN];
}

- (BOOL)deleteStringValueForKey:(NSString *)key withDomain:(NSString *)domain {
    NSString *sql = [NSString stringWithFormat:DELETE_SQL, TABLE_NAME];
    __block BOOL success;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:sql, domain, key];
    }];
    return success;
}

- (NSString *)stringValueForKey:(NSString *)key {
    return [self stringValueForKey:key withDomain:DEFAULT_DOMAIN];
}

- (NSString *)stringValueForKey:(NSString *)key withDomain:(NSString *)domain {
    NSString *sql = [NSString stringWithFormat:QUERY_SQL, TABLE_NAME];
    __block NSString *value = nil;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sql, domain, key];
        if ([rs next]) {
            value = [rs stringForColumn:@"value"];
        }
        [rs close];
    }];
    return value;
}

- (KVItem *)itemForKey:(NSString *)key {
    return [self itemForKey:key withDomain:DEFAULT_DOMAIN];
}

- (KVItem *)itemForKey:(NSString *)key withDomain:(NSString *)domain {
    NSString *sql = [NSString stringWithFormat:QUERY_SQL, TABLE_NAME];
    KVItem *item = [[KVItem alloc] init];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sql, domain, key];
        if ([rs next]) {
            item.value = [rs stringForColumn:@"value"];
            item.updatedTime = [rs dateForColumn:@"updatedTime"];
        }
        [rs close];
    }];
    return item;
}

- (BOOL)createTable {
    NSString * sql = [NSString stringWithFormat:CREATE_TABLE_SQL, TABLE_NAME];
    __block BOOL success;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        success = [db executeUpdate:sql];
    }];
    return success;
}

@end

@implementation KVItem
@end
