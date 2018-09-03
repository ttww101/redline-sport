//
//  RecommandListModel.m
//  GQapp
//
//  Created by WQ_h on 16/7/6.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "RecommandListModel.h"
#import "MedalsModel.h"
@implementation RecommandListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"casua" : @"casua",
             @"casuatwo":@"casuatwo",
             @"createtime" : @"createtime",
             @"datestr" : @"datestr",
             @"extension1" : @"extension1",
             @"extension2" : @"extension2",
             @"idId" : @"id",
             @"nickname" : @"nickname",
             @"play" : @"play",
             @"rank" : @"rank",
             @"ranktype" : @"ranktype",
             @"realnums" : @"realnums",
             @"sclassid" : @"sclassid",
             @"type" : @"type",
             @"userid" : @"userid",
             @"usertitle" : @"usertitle",
             @"medals" : @"medals",
             @"winNum" : @"winNum",
             @"goNum" : @"goNum",
             @"loseNum" : @"loseNum",

             };
}

+ (NSValueTransformer *)rankJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
        return nil;
    }];
}
+ (NSValueTransformer *)realnumsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
        return nil;
    }];
}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[MedalsModel class]];
    
}


@end
