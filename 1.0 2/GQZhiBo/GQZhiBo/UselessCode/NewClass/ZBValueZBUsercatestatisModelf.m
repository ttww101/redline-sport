#import "ZBValueZBUsercatestatisModelf.h"
@implementation ZBValueZBUsercatestatisModelf
+ (BOOL)VJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)quserinfoJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)wgoodplayJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)NgoodsclassJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)ytotalrateJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)ZsclassStatisJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)KplayStatis0JSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)zplayStatis1JSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)EplayStatis2JSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)SplayStatis3JSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)UyaPanStatisJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)UouPanStatisJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)OdxPanStatisJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)btimeStatisJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)fmonthGroupJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)uweekGroupJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}

@end
