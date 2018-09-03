#import "ZBRecord_OneModel+Zbvalue.h"
@implementation ZBRecord_OneModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}

@end
