#import "ZBUsermarkModel+Zbvalue.h"
@implementation ZBUsermarkModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}

@end
