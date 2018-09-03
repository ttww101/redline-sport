#import "ZBDan_StringGuanModel.h"
@implementation ZBDan_StringGuanModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"count" : @"count",
             @"index" : @"index",
             @"matchs":@"matchs",
             };
}
+ (NSValueTransformer *)matchsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBDan_StringMatchsModel class]];
}
@end
