#import "ZBValueZBUserViewofMyBuyTuijiany.h"
@implementation ZBValueZBUserViewofMyBuyTuijiany
+ (BOOL)JSetmodel:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)dbasicView:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)uimagePic:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)ulabName:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}
+ (BOOL)VlabStateTitle:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)vlabState:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)DviewLine:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)SaddLayout:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}

@end
