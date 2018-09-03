#import "ZBMostModel+Zbvalue.h"
@implementation ZBMostModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}

@end
