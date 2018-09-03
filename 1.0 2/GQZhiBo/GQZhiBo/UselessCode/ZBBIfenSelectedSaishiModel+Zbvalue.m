#import "ZBBIfenSelectedSaishiModel+Zbvalue.h"
@implementation ZBBIfenSelectedSaishiModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}

@end
