#import "ZBTuijiandatingModel+Zbvalue.h"
@implementation ZBTuijiandatingModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 29 == 0;
}
+ (BOOL)setHomeTeamZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)setGuestTeamZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)setGuestScoreZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}
+ (BOOL)setHomeScoreZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)setGuestTeamIDZbvalue:(NSInteger)ZBValue {
    return ZBValue % 33 == 0;
}
+ (BOOL)setHomeTeamIDZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)setLeagueNameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)setAvatarZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)setNickNameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)setmatchTimeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)setNewsIdZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)setRecommendResultZbvalue:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)setUserIdZbvalue:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)setmatchStateZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)setCanSeeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)setPlayTypeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)arrUsermarkJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)medalsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)payUsersJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}

@end
