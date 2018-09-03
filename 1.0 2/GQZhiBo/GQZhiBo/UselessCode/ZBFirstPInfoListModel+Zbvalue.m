#import "ZBFirstPInfoListModel+Zbvalue.h"
@implementation ZBFirstPInfoListModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)yaJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)dxJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)spfJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}

@end
