#import "ZBTechModel+Zbvalue.h"
@implementation ZBTechModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}

@end
