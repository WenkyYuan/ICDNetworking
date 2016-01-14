//
//  NeighborTopicTableViewCell.m
//  cloudoor
//
//  Created by wenky on 15/12/23.
//  Copyright © 2015年 Cloudoor Technology Co.,Ltd. All rights reserved.
//

#import "NeighborTopicTableViewCell.h"

#import "UIView+TLLayout.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kCollectionViewCell = @"kCollectionViewCell";
static const NSInteger kImageViewTag = 1108;

@interface NeighborTopicTableViewCell ()<
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource
>
@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation NeighborTopicTableViewCell

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat preferredWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * 16;
    self.contentLabel.preferredMaxLayoutWidth = preferredWidth;
    if (self.viewModel.images.count > 0) {
        self.contentLabel.numberOfLines = 2;
        [self.collectionView showAndRestoreConstraints];
    } else {
        [self.collectionView hideAndRemoveConstraints];
        self.contentLabel.numberOfLines = 5;
    }
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    
    UIImageView *imageView = [cell.contentView viewWithTag:kImageViewTag];
    if (imageView) {
        [imageView removeFromSuperview];
    }
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.bounds), CGRectGetHeight(cell.bounds))];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds  = YES;
    imageView.layer.cornerRadius = 4.0f;
    imageView.tag = kImageViewTag;
    
    id image = self.dataArray[indexPath.row];
    if (indexPath.row < self.dataArray.count) {
        if ([image isKindOfClass:[NSString class]]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:image]];
        } else if ([image isKindOfClass:[UIImage class]]) {
            imageView.image = image;
        }
    }
    imageView.clipsToBounds = YES;
    
    [cell.contentView addSubview:imageView];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth([UIScreen mainScreen].bounds) - 2 * 16 - (4 - 1) * self.collectionViewLayout.minimumInteritemSpacing) / 4;
    CGFloat height = width;
    self.collectionViewHeightConstraint.constant = height;
    return CGSizeMake(width, height);
}

#pragma mark - private methods
- (void)setup {
    self.avatorImageView.layer.cornerRadius = CGRectGetHeight(self.avatorImageView.bounds) / 2;
    self.avatorImageView.layer.masksToBounds = YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCell];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - setter
- (void)setViewModel:(ICDDemoViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self.avatorImageView sd_setImageWithURL:[NSURL URLWithString:viewModel.avatorUrl] placeholderImage:[UIImage imageNamed:@"avatar_placeholder_male"]];
    self.nameLabel.text = viewModel.name;
    self.locationAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", viewModel.location, viewModel.publishTime];
    self.commentCountLabel.text = [NSString stringWithFormat:@"评论%zd", viewModel.commentCount];
    self.contentLabel.text = viewModel.content;
    self.dataArray = viewModel.images;
    [self.collectionView reloadData];
}

@end

