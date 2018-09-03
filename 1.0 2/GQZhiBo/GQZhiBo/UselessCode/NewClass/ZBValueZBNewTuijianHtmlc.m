#import "ZBValueZBNewTuijianHtmlc.h"
@implementation ZBValueZBNewTuijianHtmlc
+ (BOOL)BInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)WSetsegindex:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)wChangindex:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)XdelayMethod:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}
+ (BOOL)ISetmodel:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)zloadZhiShu:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)bScrollviewdidscroll:(NSInteger)ZBValue {
    return ZBValue % 1 == 0;
}

@end
