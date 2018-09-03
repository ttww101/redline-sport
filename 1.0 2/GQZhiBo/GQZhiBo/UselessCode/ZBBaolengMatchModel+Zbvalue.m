#import "ZBBaolengMatchModel+Zbvalue.h"
@implementation ZBBaolengMatchModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}

@end
