#import "ZBTongpeiDetailModel+Zbvalue.h"
@implementation ZBTongpeiDetailModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)matchsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}

@end
