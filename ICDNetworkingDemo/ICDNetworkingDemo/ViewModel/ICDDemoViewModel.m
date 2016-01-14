//
//  ICDDemoViewModel.m
//  rank
//
//  Created by wenky on 16/1/13.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDDemoViewModel.h"
#import "SocialTopic.h"
#import "NSDate+Extras.h"
#import "ICDStringUtils.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ICDDemoViewModel ()
@property (nonatomic, strong) SocialTopic *model;
@end

@implementation ICDDemoViewModel

- (instancetype)initWithModel:(SocialTopic *)model {
    self = [super init];
    if (self) {
        _model = model;
        //使用ReactiveCocoa进行数据绑定，当model被修改时，viewModel跟随响应，同时View更新
        RAC(self, avatorUrl) = RACObserve(self.model, publishUser.portraitUrl);
        RAC(self, name) = RACObserve(self.model, publishUser.nickname);
        RAC(self, location) = RACObserve(self.model, l1ZoneId);
        RAC(self, publishTime) = [RACObserve(self.model, createTime) map:^id(NSString *value) {
            NSDate *createDate = [NSDate fromString:value format:@"yyyy-MM-dd HH:mm:ss"];
            return [ICDStringUtils toTimeString:createDate];
        }];
        RAC(self, commentCount) = RACObserve(self.model, commentCnt);
        RAC(self, content) = RACObserve(self.model, content);
        RAC(self, images) = RACObserve(self.model, photoUrls);
        
        //未进行数据绑定
//        _avatorUrl = self.model.publishUser.portraitUrl;
//        _name = self.model.publishUser.nickname;
//        _location = self.model.l1ZoneId;
//        NSDate *createDate = [NSDate fromString:self.model.createTime format:@"yyyy-MM-dd HH:mm:ss"];
//        _publishTime = [ICDStringUtils toTimeString:createDate];
//        _commentCount = self.model.commentCnt;
//        _content = self.model.content;
//        _images = self.model.photoUrls;
    }
    return self;
}

+ (NSArray *)viewModelsFromModels:(NSArray *)models {
    NSMutableArray *mubtablArray = [NSMutableArray new];
    [models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ICDDemoViewModel *viewmodel = [[ICDDemoViewModel alloc] initWithModel:obj];
        [mubtablArray addObject:viewmodel];
    }];
    return [mubtablArray copy];
}

@end
