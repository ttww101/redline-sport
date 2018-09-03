#import "ZBValueZBPlycPeilvViewT.h"
@implementation ZBValueZBPlycPeilvViewT
+ (BOOL)TInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)CBtnselected:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}
+ (BOOL)Ttaptouch:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}

@end
