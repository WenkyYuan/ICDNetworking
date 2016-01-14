//
//  ICDURLCacheDAO.m
//  rank
//
//  Created by wenky on 16/1/11.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDURLCacheDAO.h"
#import "ICDStringUtils.h"
#import "ICDServerAPIConstants.h"
#import "ICDAPPConstants.h"
#import "ICDBaseRequest.h"

@interface ICDURLCacheDAO ()
@property (nonatomic, strong) ICDBaseRequest *request;
@end

@implementation ICDURLCacheDAO

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

- (NSString *)urlCacheResponseJson {
    NSString *cacheJson;
    NSString *path = [self cacheFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil] == YES) {
        cacheJson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    return cacheJson;
}

- (void)storeUrlCacheResponseJson:(NSString *)responseJson forRequest:(ICDBaseRequest *)request {
    self.request = request;
    [NSKeyedArchiver archiveRootObject:responseJson toFile:[self cacheFilePath]];
}

- (void)checkDirectory:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

- (void)createBaseDirectoryAtPath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        NSLog(@"ICDURLCacheDAO create cache directory failed, error = %@", error);
    } else {
        [ICDStringUtils addDoNotBackupAttribute:path];
    }
}

- (NSString *)cacheBasePath {
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"LazyRequestCache"];
    [self checkDirectory:path];
    return path;
}

- (NSString *)cacheFileName {
    NSString *requestURI= self.request.requestURI;
    NSString *baseUrl = kICDServerBaseURL;
    NSString *requestJson = self.request.requestJson;
    NSString *requestMethod;
    if (self.request.requestMethod == ICDRequestMethodGET) {
        requestMethod = @"GET";
    } else {
        requestMethod = @"POST";
    }
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%@ BaseUrl:%@ URI:%@ ArgumentJson:%@ AppVersion:%@",
                             requestMethod, baseUrl, requestURI,
                             requestJson, kAppVersion];
    NSString *cacheFileName = [ICDStringUtils md5StringFromString:requestInfo];
    return cacheFileName;
}

- (NSString *)cacheFilePath {
    NSString *cacheFileName = [self cacheFileName];
    NSString *path = [self cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

@end
