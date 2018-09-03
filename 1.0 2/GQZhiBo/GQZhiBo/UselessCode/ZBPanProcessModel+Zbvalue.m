#import "ZBPanProcessModel+Zbvalue.h"
@implementation ZBPanProcessModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}

@end
