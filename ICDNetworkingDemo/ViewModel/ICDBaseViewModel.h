//
//  ICDBaseViewModel.h
//  rank
//
//  Created by wenky on 16/1/18.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICDBaseViewModel : NSObject

@property (nonatomic, readonly, strong) id model;

- (instancetype)initWithModel:(id)model;

// Model数组转换为ViewModel数组
+ (NSArray *)viewModelsFromModels:(NSArray *)models;

@end
