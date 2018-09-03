#import "ZBValueZBAllSelectedVieww.h"
@implementation ZBValueZBAllSelectedVieww
+ (BOOL)MInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)ybasicView:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)gviewLine:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)XviewCenter:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)FbtnAll:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)DbtnNotAll:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)hbtnConfirm:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)KBtnclick:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)PChangebtnselectedstate:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}

@end
