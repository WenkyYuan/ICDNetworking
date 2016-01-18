//
//  ICDDemoViewController.m
//  rank
//
//  Created by wenky on 16/1/12.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDDemoViewController.h"
#import "ICDDemoDetailViewController.h"

#import "NeighborTopicTableViewCell.h"

#import "UIView+NibLoading.h"

#import "ICDDemoService.h"

@interface ICDDemoViewController ()<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *topics;
@property (nonatomic, copy) NSArray *cellViewModels;

@end

@implementation ICDDemoViewController
- (void)dealloc {
    NSLog(@"ICDDemoViewController被注销了");
    //controller被注销时要取消所有网络请求
    [[ICDDemoService sharedManager] removeAllServices];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"列表";
    [self setupTableView];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellViewModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO:此处需要对cell高度进行缓存，否则会卡顿
    static NeighborTopicTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [NeighborTopicTableViewCell loadInstanceFromNib];
    });
    cell.viewModel = self.cellViewModels[indexPath.row];
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame),CGRectGetHeight(cell.bounds));
    [cell setNeedsLayout];
    [cell layoutSubviews];
    CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *nibName = NSStringFromClass([NeighborTopicTableViewCell class]);
    NeighborTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibName forIndexPath:indexPath];
    cell.viewModel = self.cellViewModels[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SocialTopic *topic = self.topics[indexPath.row];
    ICDDemoDetailViewController *vc = [[ICDDemoDetailViewController alloc] init];
    vc.topic = topic;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private methods
- (void)setupTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    NSString *nibName = NSStringFromClass([NeighborTopicTableViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

- (void)setupData {
    [[ICDDemoService sharedManager] queryTopicsByScope:1 offset:0 limit:10 completion:^(NSArray *topics, NSError *error) {
        NSLog(@"处理数据成功！");
        if (error) {
            return;
        }
        self.topics = topics;
        self.cellViewModels = [ICDDemoViewModel viewModelsFromModels:self.topics];
        [self.tableView reloadData];
    }];
}

- (NSArray *)cellViewModels {
    if (!_cellViewModels) {
        _cellViewModels = [NSArray new];
    }
    return _cellViewModels;
}

@end
