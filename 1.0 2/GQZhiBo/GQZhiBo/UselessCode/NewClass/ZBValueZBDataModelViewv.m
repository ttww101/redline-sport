#import "ZBValueZBDataModelViewv.h"
@implementation ZBValueZBDataModelViewv
+ (BOOL)CInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)hSelectedinfo:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)pPreventflicker:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)fpagecontrol:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)HScrollviewdidscroll:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}

@end
