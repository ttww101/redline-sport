#import "ZBValueZBWebviewProgressLineY.h"
@implementation ZBValueZBWebviewProgressLineY
+ (BOOL)fInitwithframezbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}
+ (BOOL)SSetlinecolorzbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)LStartloadinganimationzbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)BEndloadinganimationzbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}

@end
