#import "ZBCommentModel+Zbvalue.h"
@implementation ZBCommentModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)childJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}

@end
