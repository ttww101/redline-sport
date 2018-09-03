#import "ZBBaolengDTTitleView+Zbvalue.h"
@implementation ZBBaolengDTTitleView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)labLeagueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)labTimeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)labHomteamZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)labGuestteamZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)labVSZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)labPeilvZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}

@end
