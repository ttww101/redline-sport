#import "ZBTongpeiDTModel+Zbvalue.h"
@implementation ZBTongpeiDTModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)sameJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)allJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}

@end
