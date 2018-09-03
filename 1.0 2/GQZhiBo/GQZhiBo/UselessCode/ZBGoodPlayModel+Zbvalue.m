#import "ZBGoodPlayModel+Zbvalue.h"
@implementation ZBGoodPlayModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}

@end
