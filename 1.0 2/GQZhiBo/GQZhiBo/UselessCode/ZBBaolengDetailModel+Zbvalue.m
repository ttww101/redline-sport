#import "ZBBaolengDetailModel+Zbvalue.h"
@implementation ZBBaolengDetailModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)bodyJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)listJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}

@end
