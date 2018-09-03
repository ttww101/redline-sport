#import "ZBBuyerModel+Zbvalue.h"
@implementation ZBBuyerModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 10 == 0;
}

@end
