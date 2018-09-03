#import "ZBNavigationModel+Zbvalue.h"
@implementation ZBNavigationModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}

@end
