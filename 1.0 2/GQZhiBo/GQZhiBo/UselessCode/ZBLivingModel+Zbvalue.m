#import "ZBLivingModel+Zbvalue.h"
@implementation ZBLivingModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}

@end
