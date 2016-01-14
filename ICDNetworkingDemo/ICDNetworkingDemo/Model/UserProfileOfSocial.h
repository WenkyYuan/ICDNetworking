//
//  UserProfileOfSocial.h
//  rank
//
//  Created by wenky on 16/1/11.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用户类型
typedef NS_ENUM(NSUInteger, UserType) {
    UserTypeNormal = 0, // 普通用户帐号
    UserTypeOfficial, // 官方帐号
    UserTypeHousingEstate, // 小区帐号
    UserTypeMerchant, //商户
};

@interface UserProfileOfSocial : NSObject

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *portraitUrl;
@property (nonatomic, assign) UserType type;

@end
