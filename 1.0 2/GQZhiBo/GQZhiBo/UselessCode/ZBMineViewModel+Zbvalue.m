#import "ZBMineViewModel+Zbvalue.h"
@implementation ZBMineViewModel (Zbvalue)
+ (BOOL)getMineDataArrayZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}

@end
