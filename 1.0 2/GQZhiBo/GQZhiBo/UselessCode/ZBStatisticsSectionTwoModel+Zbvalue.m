#import "ZBStatisticsSectionTwoModel+Zbvalue.h"
@implementation ZBStatisticsSectionTwoModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}

@end
