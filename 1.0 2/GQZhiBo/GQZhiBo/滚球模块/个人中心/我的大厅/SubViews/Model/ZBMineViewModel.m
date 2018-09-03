//
//  ZBMineViewModel.m
//  newGQapp
//
//  Created by genglei on 2018/4/27.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ZBMineViewModel.h"

@implementation ZBMineViewModel

+ (NSArray *)getMineDataArray {
    NSMutableArray *groupArray = [NSMutableArray array];
    
    NSArray *imageArray1 = @[@"image13", @"image2", @"image3"];
    NSArray *leftContentArry1 = @[@"我的竞猜", @"账户明细", @"购买记录"];
    NSMutableArray *array1 = [NSMutableArray new];
    for (NSInteger i = 0; i < imageArray1.count; i ++) {
        ZBMineModel *model = [[ZBMineModel alloc]init];
        model.leftContent = leftContentArry1[i];
        model.leftImageName = imageArray1[i];
        model.rightImageName = @"meRight";
        [array1 addObject:model];
    }
    [groupArray addObject:array1];
    
    NSArray *imageArra2 = @[@"image11", @"image12",@"image5", @"image1"];
    NSArray *leftContentArry2 = @[@"分析师收入", @"优惠券", @"推荐统计", @"滚球服务"];
    NSMutableArray *array2 = [NSMutableArray new];
    for (NSInteger i = 0; i < imageArra2.count; i ++) {
        ZBMineModel *model = [[ZBMineModel alloc]init];
        model.leftContent = leftContentArry2[i];
        model.leftImageName = imageArra2[i];
        model.rightImageName = @"meRight";
        [array2 addObject:model];
    }
    [groupArray addObject:array2];
    
//    NSArray *imageArra3 = @[@"image6", @"image7"];
//    NSArray *leftContentArry3 = @[@"我的关注", @"我的粉丝"];
//    NSMutableArray *array3 = [NSMutableArray new];
//    for (NSInteger i = 0; i < imageArra3.count; i ++) {
//        ZBMineModel *model = [[ZBMineModel alloc]init];
//        model.leftContent = leftContentArry3[i];
//        model.leftImageName = imageArra3[i];
//        model.rightImageName = @"meRight";
//        [array3 addObject:model];
//    }
//    [groupArray addObject:array3];
    
    NSArray *imageArra4 = @[@"image8", @"image9", @"image10"];
    NSArray *leftContentArry4 = @[@"邀请好友", @"意见反馈", @"更多设置"];
    NSMutableArray *array4 = [NSMutableArray new];
    for (NSInteger i = 0; i < imageArra4.count; i ++) {
        ZBMineModel *model = [[ZBMineModel alloc]init];
        model.leftContent = leftContentArry4[i];
        model.leftImageName = imageArra4[i];
        model.rightImageName = @"meRight";
        if (i == 0) {
            model.rightContent = @"邀请好友得滚球币";
        }
        [array4 addObject:model];
    }
    [groupArray addObject:array4];
    
    return groupArray;
   
}

@end
