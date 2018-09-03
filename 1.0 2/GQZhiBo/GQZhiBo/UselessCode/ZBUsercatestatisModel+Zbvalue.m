#import "ZBUsercatestatisModel+Zbvalue.h"
@implementation ZBUsercatestatisModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)userinfoJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)goodplayJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)goodsclassJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)totalrateJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)sclassStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)playStatis0JSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)playStatis1JSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)playStatis2JSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)playStatis3JSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)yaPanStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)ouPanStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)dxPanStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)timeStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)monthGroupJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)weekGroupJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}

@end
