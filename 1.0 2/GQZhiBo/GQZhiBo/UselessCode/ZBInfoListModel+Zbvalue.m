#import "ZBInfoListModel+Zbvalue.h"
@implementation ZBInfoListModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)GuestScoreJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)HomeScoreJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)multipleJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}
+ (BOOL)recommend_countJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}
+ (BOOL)info_countJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)fansJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)win_rateJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)profit_rateJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}
+ (BOOL)create_timeJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)MatchTimeJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)medalsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}

@end
