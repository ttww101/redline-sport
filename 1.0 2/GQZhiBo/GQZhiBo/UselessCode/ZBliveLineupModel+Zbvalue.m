#import "ZBliveLineupModel+Zbvalue.h"
@implementation ZBliveLineupModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)goalsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)teamidJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)assistJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)roundsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)playeridJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)bestsumJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)ratingJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)typeratingJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}

@end
