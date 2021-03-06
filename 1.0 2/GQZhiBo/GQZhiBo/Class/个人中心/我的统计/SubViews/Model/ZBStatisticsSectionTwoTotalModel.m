#import "ZBStatisticsSectionTwoTotalModel.h"
@implementation ZBStatisticsSectionTwoTotalModel
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
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arrouPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arrplayStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arrsclassStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arrtimeStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arryaPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arryaChuanGuanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBStatisticsSectionTwoModel class]];
}
@end
