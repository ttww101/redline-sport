#import "ZBValueZBDan_StringMatchsModelG.h"
@implementation ZBValueZBDan_StringMatchsModelG
+ (BOOL)gJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)VdxJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)DpriceListJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)crqJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)pspfJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}

@end
