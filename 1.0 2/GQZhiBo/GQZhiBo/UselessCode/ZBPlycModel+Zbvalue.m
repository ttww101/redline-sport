#import "ZBPlycModel+Zbvalue.h"
@implementation ZBPlycModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)panProcessJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}

@end
