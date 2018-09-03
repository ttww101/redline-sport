#import "ZBValueZBUserTuiianViewm.h"
@implementation ZBValueZBUserTuiianViewm
+ (BOOL)Dinit:(NSInteger)ZBValue {
    return ZBValue % 10 == 0;
}
+ (BOOL)GSetmodel:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)bBtnclick:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}

@end
