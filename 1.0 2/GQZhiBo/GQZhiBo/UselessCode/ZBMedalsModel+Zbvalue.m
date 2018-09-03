#import "ZBMedalsModel+Zbvalue.h"
@implementation ZBMedalsModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}

@end
