//
//  SocialTopic.h
//  cloudoor
//
//  Created by wenky on 15/12/25.
//  Copyright © 2015年 Cloudoor Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileOfSocial.h"

@interface SocialTopic : NSObject
@property (nonatomic, copy) NSString *socialId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSArray *photoUrls;
@property (nonatomic, assign) NSInteger commentCnt;
@property (nonatomic, assign) NSInteger likeCnt;
@property (nonatomic, copy) NSString *l1ZoneId;
@property (nonatomic, strong) UserProfileOfSocial *publishUser;

@end
