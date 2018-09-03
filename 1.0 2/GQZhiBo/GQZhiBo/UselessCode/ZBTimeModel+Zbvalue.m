#import "ZBTimeModel+Zbvalue.h"
@implementation ZBTimeModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}

@end
