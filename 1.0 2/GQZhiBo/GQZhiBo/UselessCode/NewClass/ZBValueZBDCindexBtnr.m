#import "ZBValueZBDCindexBtnr.h"
@implementation ZBValueZBDCindexBtnr
+ (BOOL)ZInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)TtouchTap:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)NimgScroll:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)mUpdatescrollframe:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)GUpdatescrollbyselfframe:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)sPanaction:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}
+ (BOOL)ahideSelf:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}

@end
