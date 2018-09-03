#import "ZBPeilvViewOfPlyc+Zbvalue.h"
@implementation ZBPeilvViewOfPlyc (Zbvalue)
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)labcompanyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)labJPTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)labJP1Zbvalue:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)labJP2Zbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)labJP3Zbvalue:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)labJPTimeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)labCPTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}
+ (BOOL)labCP1Zbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)labCP2Zbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)labCP3Zbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)labWinTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)labWinZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)labPingTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)labPingZbvalue:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)labLoseTitleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}
+ (BOOL)labLoseZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)imageJP1Zbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)imageJP2Zbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}
+ (BOOL)imageJP3Zbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)imageWinZbvalue:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}
+ (BOOL)imagePingZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)imageLoseZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)viewLineZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}
+ (BOOL)addlayoutZbvalue:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}

@end
