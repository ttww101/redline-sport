#import "ZBValueZBJiBenWebViewi.h"
@implementation ZBValueZBJiBenWebViewi
+ (BOOL)ZInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)zSetmodel:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)floadFenXi:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)IloadTongjiTezheng:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)kScrollviewdidscroll:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}

@end
