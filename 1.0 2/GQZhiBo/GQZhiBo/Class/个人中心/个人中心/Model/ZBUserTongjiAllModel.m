#import "ZBUserTongjiAllModel.h"
@implementation ZBUserTongjiAllModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"month" : @"month",
             @"all" : @"all",
             @"week" : @"week",
             @"recent" : @"recent",
             };
}
+ (NSValueTransformer *)monthJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBUserTongjiModel class]];
}
+ (NSValueTransformer *)allJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBUserTongjiModel class]];
}
+ (NSValueTransformer *)weekJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[ZBUserTongjiModel class]];
}
@end
