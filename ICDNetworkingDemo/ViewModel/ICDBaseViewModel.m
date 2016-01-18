//
//  ICDBaseViewModel.m
//  rank
//
//  Created by wenky on 16/1/18.
//  Copyright © 2016年 wenky. All rights reserved.
//

#import "ICDBaseViewModel.h"

@implementation ICDBaseViewModel

- (id)init {
    return [self initWithModel:nil];
}

- (id)initWithModel:(id)model {
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

+ (NSArray *)viewModelsFromModels:(NSArray *)models {
    NSMutableArray *mubtablArray = [NSMutableArray new];
    [models enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id viewmodel = [[[self class] alloc] initWithModel:obj];
        [mubtablArray addObject:viewmodel];
    }];
    return [mubtablArray copy];
}

@end
