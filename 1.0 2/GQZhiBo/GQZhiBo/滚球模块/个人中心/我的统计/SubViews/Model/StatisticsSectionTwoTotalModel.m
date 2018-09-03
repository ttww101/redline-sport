//
//  StatisticsSectionTwoTotalModel.m
//  GQapp
//
//  Created by WQ_h on 16/8/16.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "StatisticsSectionTwoTotalModel.h"
@implementation StatisticsSectionTwoTotalModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"arrdxPanStatis" : @"dxPanStatis",
             @"arrouPanStatis" : @"ouPanStatis",
             @"arrplayStatis" : @"playStatis",
             @"arrsclassStatis" : @"sclassStatis",
             @"arrtimeStatis" : @"timeStatis",
             @"arryaPanStatis" : @"yaPanStatis",
             @"arryaChuanGuanStatis" : @"chuanGuanStatis",
             };
}

+ (NSValueTransformer *)arrdxPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)arrouPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)arrplayStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)arrsclassStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)arrtimeStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)arryaPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}
+ (NSValueTransformer *)arryaChuanGuanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[StatisticsSectionTwoModel class]];
    
}

@end
