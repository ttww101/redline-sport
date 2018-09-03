#import "ZBValueZBUserTongjiAllModelc.h"
@implementation ZBValueZBUserTongjiAllModelc
+ (BOOL)uJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 7 == 0;
}
+ (BOOL)dmonthJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)BallJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}
+ (BOOL)iweekJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}

@end
