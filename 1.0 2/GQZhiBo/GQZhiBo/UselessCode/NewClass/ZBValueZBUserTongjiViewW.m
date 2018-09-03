#import "ZBValueZBUserTongjiViewW.h"
@implementation ZBValueZBUserTongjiViewW
+ (BOOL)cInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)ESetmodel:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)NbasicView:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)jlabWinRate:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)MlabWinRateTitle:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)nlabProfite:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)IlabProfiteTitle:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)UroundTitle:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)broundNum:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)CwinTitle:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)iwinNum:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)czouTitle:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)BzouNum:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)CloseTitle:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)sloseNum:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)sviewCenter:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)pviewBottom:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)wsetautolayout:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}

@end
