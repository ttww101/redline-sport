#import "ZBStatisticsModel+Zbvalue.h"
@implementation ZBStatisticsModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)goodPlayJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)goodsclassJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)RecoommandmodelJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)arrTotalrateJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)arrUsertitleJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)medalsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}

@end
