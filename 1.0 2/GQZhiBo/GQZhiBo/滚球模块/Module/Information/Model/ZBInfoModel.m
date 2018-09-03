//
//  ZBInfoModel.m
//  newGQapp
//
//  Created by genglei on 2018/7/17.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ZBInfoModel.h"

@implementation ZBInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"InfoGroupModel") };
}

@end

@implementation InfoGroupModel

@end
