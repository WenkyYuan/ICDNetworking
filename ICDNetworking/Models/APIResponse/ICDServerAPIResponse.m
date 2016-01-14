//
//  ICDServerAPIResponse.m
//  rank
//
//  Created by wenky on 16/1/9.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDServerAPIResponse.h"
#import "ICDServerAPIConstants.h"
#import "ICDErrorUtils.h"

static NSString *kUnknownError = @"未知错误";

@implementation ICDServerAPIResponse

- (instancetype)init {
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _code = [[dict objectForKey:@"code"] integerValue];
        _message = [[dict objectForKey:@"message"] copy];
        _data = [[dict objectForKey:@"data"] copy];
        _sid = [[dict objectForKey:@"sid"] copy];
    }
    return self;
}

- (BOOL)success {
    return _code == kICDServerAPICodeSuccess;
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"success"];
}

@end


@implementation ICDServerAPIResponse (Error)

+ (instancetype)responseForNetworkErrorWithMessage:(NSString *)message {
    NSDictionary *dict;
    if (message) {
        dict = @{@"code": @(kICDServerAPICodeNetworkError), @"message": message};
    } else {
        dict = @{@"code": @(kICDServerAPICodeNetworkError)};
    }
    ICDServerAPIResponse *instance = [[ICDServerAPIResponse alloc] initWithDictionary:dict];
    return instance;
}

+ (instancetype)responseForMalformedResponseErrorWithMessage:(NSString *)message {
    NSDictionary *dict;
    if (message) {
        dict = @{@"code": @(kICDServerAPICodeMalformedResponse), @"message": message};
    } else {
        dict = @{@"code": @(kICDServerAPICodeMalformedResponse)};
    }
    ICDServerAPIResponse *instance = [[ICDServerAPIResponse alloc] initWithDictionary:dict];
    return instance;
}

- (NSString *)errorMessage {
    if (self.success) {
        return nil;
    }
    NSString *errorMessage = [[[self class] errorMessageDictionary] objectForKey:@(self.code)];
    if (errorMessage.length == 0) {
        errorMessage = kUnknownError;
    }
    return errorMessage;
}

- (NSError *)error {
    if ([self success]) {
        return nil;
    }
    NSError *error = [ICDErrorUtils errorWithDomain:kErrorDomainServerAPIBusinessError code:self.code message:[self errorMessage]];
    return error;
}

+ (NSDictionary *)errorMessageDictionary {
    static NSDictionary *dict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = @{
                 @(kICDServerAPICodeNetworkError): @"网络异常",
                 @(kICDServerAPICodeMalformedResponse): @"系统异常",
                 @(kICDServerAPICodeNotLoggedIn): @"未登录",
                 @(kICDServerAPICodeIllegalParameters): @"输入内容不符合要求",
                 @(kICDServerAPICodeServerError): @"系统繁忙",
                 @(kICDServerAPICodeUploadError): @"上传失败",
                 };
    });
    return dict;
}

@end
