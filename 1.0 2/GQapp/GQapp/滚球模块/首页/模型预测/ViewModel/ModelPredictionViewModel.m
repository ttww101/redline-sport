
//
//  ModelPredictionViewModel.m
//  newGQapp
//
//  Created by genglei on 2018/3/30.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ModelPredictionViewModel.h"

@implementation ModelPredictionViewModel

+ (NSArray *)createModelListArray {
    NSArray *imageArray = @[@"winorfail", @"yapan", @"daxiaoqiu"];
    NSArray *titleArray = @[@"胜平负", @"亚盘", @"大小球"];
    NSMutableArray *array = [NSMutableArray array];
    [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UniversaListCellModel *model = [[UniversaListCellModel alloc]init];
        model.leftIconImageName = imageArray[idx];
        model.content = titleArray[idx];
        model.index = idx;
        [array addObject:model];
    }];
    return array;
}

@end
