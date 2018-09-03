#import "ZBFansModel+Zbvalue.h"
@implementation ZBFansModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}

@end
