#import "ZBValueZBTongpeiPeilvChangeTItleViewx.h"
@implementation ZBValueZBTongpeiPeilvChangeTItleViewx
+ (BOOL)HInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)obasicView:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)flabPeilv:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}
+ (BOOL)flabKaili:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)llabBackRate:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)jlabTime:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}

@end
