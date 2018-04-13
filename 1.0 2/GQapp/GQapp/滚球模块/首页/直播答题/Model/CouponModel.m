//
//  CouponModel.m
//  newGQapp
//
//  Created by genglei on 2018/4/13.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"couponID" : @"id"
             };
}

@end

@implementation CouponListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"CouponModel") };
}


@end
