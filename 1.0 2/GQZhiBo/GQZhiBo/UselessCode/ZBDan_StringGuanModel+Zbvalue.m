#import "ZBDan_StringGuanModel+Zbvalue.h"
@implementation ZBDan_StringGuanModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)matchsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}

@end
