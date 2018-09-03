#import "ZBValueZBBaolengZhishuCellX.h"
@implementation ZBValueZBBaolengZhishuCellX
+ (BOOL)YawakeFromNib:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)gSetselectedPAnimated:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)NSetmodel:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)BbasicView:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)dlabQici:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)klabLeague:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)JlabTime:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)ElabHomteam:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}
+ (BOOL)jlabGuestteam:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)YlabVS:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)TlabCompany:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)blabPankou:(NSInteger)ZBValue {
    return ZBValue % 41 == 0;
}
+ (BOOL)OlabPeilvUp:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)ilabpeilvGoal:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)PlabPeilvDown:(NSInteger)ZBValue {
    return ZBValue % 29 == 0;
}
+ (BOOL)MlabBaolengRate:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}
+ (BOOL)vlabRateTitle:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)ElabHisttoryBaoleng:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)UlabRateTitleLast:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)bviewLine:(NSInteger)ZBValue {
    return ZBValue % 10 == 0;
}
+ (BOOL)Kaddlayout:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}

@end
