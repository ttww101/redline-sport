#import "ZBValueZBWebviewProgressLineY+Zbvalue.h"
@implementation ZBValueZBWebviewProgressLineY (Zbvalue)
+ (BOOL)fInitwithframezbvalueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)SSetlinecolorzbvalueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)LStartloadinganimationzbvalueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)BEndloadinganimationzbvalueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}

@end
