#import "ZBUserTongjiAllModel+Zbvalue.h"
@implementation ZBUserTongjiAllModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}
+ (BOOL)monthJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)allJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)weekJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}

@end
