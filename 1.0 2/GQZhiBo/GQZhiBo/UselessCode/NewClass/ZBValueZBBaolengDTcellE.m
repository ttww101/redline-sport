#import "ZBValueZBBaolengDTcellE.h"
@implementation ZBValueZBBaolengDTcellE
+ (BOOL)AawakeFromNib:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)sSetselectedgAnimated:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)BSetmodel:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)JbasicView:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)nlabLeague:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)RlabTime:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)jlabHomteam:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)slabGuestteam:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)llabVS:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}
+ (BOOL)mlabPeilvUp:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)llabpeilvGoal:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)ulabPeilvDown:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}

@end
