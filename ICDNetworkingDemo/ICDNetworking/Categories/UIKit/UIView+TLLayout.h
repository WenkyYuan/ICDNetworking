//
//  UIView+TLLayout.h
//  rank
//
//  Created by wenky on 16/1/13.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TLLayout)
@property (nonatomic, strong) NSArray *hiddenConstraints;

// set hidden and remove any constraints involving this view from its superview
- (void)hideAndRemoveConstraints;
- (void)showAndRestoreConstraints;

@end
