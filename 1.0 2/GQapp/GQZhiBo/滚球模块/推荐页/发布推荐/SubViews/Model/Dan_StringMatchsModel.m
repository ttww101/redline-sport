//
//  Dan_StringMatchsModel.m
//  GQapp
//
//  Created by 叶忠阳 on 16/9/5.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "Dan_StringMatchsModel.h"

@implementation Dan_StringMatchsModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"dx1" : @"dx1",
             @"dx2" : @"dx2",
             @"dx3":@"dx3",
             @"guestteam" : @"guestteam",
             @"hometeam" : @"hometeam",
             @"guestteamid":@"guestteamid",
             @"hometeamid":@"hometeamid",
             @"league":@"league",
             @"leagueId":@"leagueId",
             @"matchstate" : @"matchstate",
             @"matchtime" : @"matchtime",
             @"rq1":@"rq1",
             @"rq2" : @"rq2",
             @"rq3" : @"rq3",
             @"sid":@"sid",
             @"sort" : @"sort",
             @"spf1" : @"spf1",
             @"spf2":@"spf2",
             @"spf3":@"spf3",
             @"rqodds":@"rqodds",
             @"dxodds":@"dxodds",
             @"dx":@"dx",
             @"rq":@"rq",
             @"spf":@"spf",
             @"spfcompany":@"spfcompany",
             @"rqcompany":@"rqcompany",
             @"dxcompany":@"dxcompany",
             @"leagueColor":@"leagueColor",
             @"priceList":@"priceList",
             
             };
}

+ (NSValueTransformer *)dxJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[DxModel class]];
    
}
+ (NSValueTransformer *)priceListJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[PriceListModel class]];
    
}

+ (NSValueTransformer *)rqJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[DxModel class]];
    
}
+ (NSValueTransformer *)spfJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[DxModel class]];
    
}

@end
