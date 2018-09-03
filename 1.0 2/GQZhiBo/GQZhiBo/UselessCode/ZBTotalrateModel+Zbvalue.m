#import "ZBTotalrateModel+Zbvalue.h"
@implementation ZBTotalrateModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}

@end
