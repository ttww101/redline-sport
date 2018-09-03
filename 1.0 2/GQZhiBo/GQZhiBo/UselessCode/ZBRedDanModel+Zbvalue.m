#import "ZBRedDanModel+Zbvalue.h"
@implementation ZBRedDanModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}

@end
