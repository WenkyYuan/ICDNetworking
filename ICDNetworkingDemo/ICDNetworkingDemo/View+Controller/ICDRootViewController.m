//
//  ICDRootViewController.m
//  rank
//
//  Created by wenky on 16/1/12.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDRootViewController.h"
#import "ICDDemoViewController.h"

@interface ICDRootViewController ()

@end

@implementation ICDRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ICDNetworking+MVVM";
    [self setupRightNavigationBar];
}

- (void)setupRightNavigationBar {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"列表" style:UIBarButtonItemStylePlain target:self action:@selector(didTapRightBar)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didTapRightBar {
    ICDDemoViewController *vc = [[ICDDemoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
