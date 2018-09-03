#import "ZBValueZBSelectedSaiGuoTitleViewN.h"
@implementation ZBValueZBSelectedSaiGuoTitleViewN
+ (BOOL)wInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)YSetarrdata:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)USetdateindex:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)rupdateSubViewBeforeTwo:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)XBtndateclick:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)VBtnleftclick:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)IBtnrightclick:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}

@end
