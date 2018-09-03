#import "ZBValueZBFenXiHeaderBottomViewO.h"
@implementation ZBValueZBFenXiHeaderBottomViewO
+ (BOOL)PInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)DSetmodel:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)sbasicView:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)UiconTQ:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)xlabTQ:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)FlabTQNum:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)KlabPlace:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)llabAdress:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)kaddAutolayout:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}

@end
