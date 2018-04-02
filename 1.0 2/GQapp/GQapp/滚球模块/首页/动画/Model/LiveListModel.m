//
//  LiveListModel.m
//  GQLive
//
//  Created by genglei on 2018/3/19.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "LiveListModel.h"

@implementation LiveListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
}

@end

@implementation LiveListArrayModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"LiveListModel") };
}

@end
