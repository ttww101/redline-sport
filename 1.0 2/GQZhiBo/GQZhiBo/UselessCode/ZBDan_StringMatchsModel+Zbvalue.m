#import "ZBDan_StringMatchsModel+Zbvalue.h"
@implementation ZBDan_StringMatchsModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)dxJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)priceListJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)rqJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)spfJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}

@end
