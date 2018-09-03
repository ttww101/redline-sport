#import "ZBTongpeiDTModel.h"
@implementation ZBTongpeiDTModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"same" : @"same",
             @"all" : @"all",
             };
}
+ (NSValueTransformer *)sameJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBTongpeiDetailModel class]];
}
+ (NSValueTransformer *)allJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBTongpeiDetailModel class]];
}
@end
