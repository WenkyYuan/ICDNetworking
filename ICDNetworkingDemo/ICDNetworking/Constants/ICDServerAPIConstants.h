//
//  ICDServerAPIConstants.h
//  rank
//
//  Created by wenky on 16/1/4.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kICDServerBaseURL;

// 处理成功
extern const NSInteger kICDServerAPICodeSuccess;
// 网络异常
extern const NSInteger kICDServerAPICodeNetworkError;
// 服务端返回的数据无法识别
extern const NSInteger kICDServerAPICodeMalformedResponse;

// 用户未登录
extern const NSInteger kICDServerAPICodeNotLoggedIn;
// 输入参数不符合要求
extern const NSInteger kICDServerAPICodeIllegalParameters;
// 服务端异常
extern const NSInteger kICDServerAPICodeServerError;

// 上传文件失败
extern const NSInteger kICDServerAPICodeUploadError;
