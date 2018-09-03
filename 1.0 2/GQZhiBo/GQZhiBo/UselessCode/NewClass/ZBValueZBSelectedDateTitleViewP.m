#import "ZBValueZBSelectedDateTitleViewP.h"
@implementation ZBValueZBSelectedDateTitleViewP
+ (BOOL)OInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)eSetarrdata:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)ISetdateindex:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}
+ (BOOL)supdateSubView:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)GBtnleftclick:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)HBtnrightclick:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}

@end
