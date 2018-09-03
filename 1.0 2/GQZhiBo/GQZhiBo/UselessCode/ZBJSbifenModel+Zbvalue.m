#import "ZBJSbifenModel+Zbvalue.h"
@implementation ZBJSbifenModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)dataJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}

@end
