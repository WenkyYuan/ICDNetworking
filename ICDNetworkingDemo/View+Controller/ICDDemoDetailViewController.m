//
//  ICDDemoDetailViewController.m
//  rank
//
//  Created by wenky on 16/1/13.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDDemoDetailViewController.h"
#import "SocialTopic.h"

@interface ICDDemoDetailViewController ()

@end

@implementation ICDDemoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情";
    self.topic.content = @"测试ViewModel的数据绑定，修改Model时ViewModel也跟随修改，同时更新View";
    self.topic.photoUrls = @[];
}

@end
