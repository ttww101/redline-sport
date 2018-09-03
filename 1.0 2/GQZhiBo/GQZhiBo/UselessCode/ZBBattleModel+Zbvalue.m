#import "ZBBattleModel+Zbvalue.h"
@implementation ZBBattleModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}

@end
