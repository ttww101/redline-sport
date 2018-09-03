#import "ZBFocusModel+Zbvalue.h"
@implementation ZBFocusModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}

@end
