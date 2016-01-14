//
//  ICDServerAPIConstants.m
//  rank
//
//  Created by wenky on 16/1/4.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDServerAPIConstants.h"

NSString *const kICDServerBaseURL = @"http://test.zone.icloudoor.com/icloudoor-web";

// 处理成功
const NSInteger kICDServerAPICodeSuccess = 1;
// 网络异常
const NSInteger kICDServerAPICodeNetworkError = -11111;
// 服务端返回的数据无法识别
const NSInteger kICDServerAPICodeMalformedResponse = -11112;

// 用户未登录
const NSInteger kICDServerAPICodeNotLoggedIn = -2;
// 输入参数不符合要求
const NSInteger kICDServerAPICodeIllegalParameters = -1;
// 服务端异常
const NSInteger kICDServerAPICodeServerError = -99;
// 上传失败
const NSInteger kICDServerAPICodeUploadError = -78;