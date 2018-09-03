#import "ZBUserModel+Zbvalue.h"
@implementation ZBUserModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)medalsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}

@end
