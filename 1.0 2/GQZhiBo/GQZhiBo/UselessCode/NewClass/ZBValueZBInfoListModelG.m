#import "ZBValueZBInfoListModelG.h"
@implementation ZBValueZBInfoListModelG
+ (BOOL)rJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)xGuestScoreJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)dHomeScoreJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)nmultipleJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)Brecommend_countJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)finfo_countJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)jfansJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)Nwin_rateJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)gprofit_rateJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)jcreate_timeJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)JMatchTimeJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)LmedalsJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}

@end
