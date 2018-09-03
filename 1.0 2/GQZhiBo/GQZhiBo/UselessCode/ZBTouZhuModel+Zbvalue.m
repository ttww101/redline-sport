#import "ZBTouZhuModel+Zbvalue.h"
@implementation ZBTouZhuModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}

@end
