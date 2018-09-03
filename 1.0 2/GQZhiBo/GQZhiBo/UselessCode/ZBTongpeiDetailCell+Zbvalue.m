#import "ZBTongpeiDetailCell+Zbvalue.h"
@implementation ZBTongpeiDetailCell (Zbvalue)
+ (BOOL)awakeFromNibZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)setSelectedAnimatedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)ViewPingCenterZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)labLeagueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)labTimeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)labHomteamZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)labGuestteamZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)labHomeScoreZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)labGuestScoreZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)labHomePankouwinZbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)labHomePankoupingZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)labHomePankouloseZbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)labGuestPankouwinZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)labGuestPankoupingZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)labGuestPankouloseZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)labWinZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)addLayoutZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}

@end
