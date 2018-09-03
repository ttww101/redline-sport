#import "ZBRecommandListModel+Zbvalue.h"
@implementation ZBRecommandListModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)rankJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)realnumsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)medalsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}

@end
