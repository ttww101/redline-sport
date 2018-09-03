#import "ZBValueZBPriceListModelY.h"
@implementation ZBValueZBPriceListModelY
+ (BOOL)LJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}

@end
