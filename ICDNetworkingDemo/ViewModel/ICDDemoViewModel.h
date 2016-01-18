//
//  ICDDemoViewModel.h
//  rank
//
//  Created by wenky on 16/1/13.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDBaseViewModel.h"
@class SocialTopic;

@interface ICDDemoViewModel : ICDBaseViewModel
@property (nonatomic, copy) NSString *avatorUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *publishTime;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSArray *images; // url或者UIImage

- (instancetype)initWithModel:(SocialTopic *)model;

@end
