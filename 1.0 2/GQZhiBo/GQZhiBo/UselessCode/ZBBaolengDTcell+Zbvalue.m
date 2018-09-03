#import "ZBBaolengDTcell+Zbvalue.h"
@implementation ZBBaolengDTcell (Zbvalue)
+ (BOOL)awakeFromNibZbvalue:(NSInteger)ZBValue {
    return ZBValue % 41 == 0;
}
+ (BOOL)setSelectedAnimatedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 29 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)labLeagueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)labTimeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}
+ (BOOL)labHomteamZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)labGuestteamZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)labVSZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)labPeilvUpZbvalue:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)labpeilvGoalZbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)labPeilvDownZbvalue:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}

@end
