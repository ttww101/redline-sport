#import "ZBBaolengDetailModel.h"
@implementation ZBBaolengDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"body" : @"body" ,
             @"list" : @"list" ,
             };
}
+ (NSValueTransformer *)bodyJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBBaolengDTModel class]];
}
+ (NSValueTransformer *)listJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[ZBBaolengMatchModel class]];
}
@end
