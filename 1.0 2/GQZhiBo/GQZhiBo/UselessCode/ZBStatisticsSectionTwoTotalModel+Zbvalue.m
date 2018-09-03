#import "ZBStatisticsSectionTwoTotalModel+Zbvalue.h"
@implementation ZBStatisticsSectionTwoTotalModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)arrdxPanStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)arrouPanStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)arrplayStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)arrsclassStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)arrtimeStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)arryaPanStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)arryaChuanGuanStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}

@end
