#import "ZBUserTongjiModel+Zbvalue.h"
@implementation ZBUserTongjiModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}
+ (BOOL)groupTimeStatisJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}

@end
