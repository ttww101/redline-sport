#import "ZBPriceListModel+Zbvalue.h"
@implementation ZBPriceListModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}

@end
