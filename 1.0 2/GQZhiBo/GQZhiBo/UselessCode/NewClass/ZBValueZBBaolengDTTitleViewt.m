#import "ZBValueZBBaolengDTTitleViewt.h"
@implementation ZBValueZBBaolengDTTitleViewt
+ (BOOL)hInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)SbasicView:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)ylabLeague:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)PlabTime:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)klabHomteam:(NSInteger)ZBValue {
    return ZBValue % 43 == 0;
}
+ (BOOL)GlabGuestteam:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)plabVS:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)PlabPeilv:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}

@end
