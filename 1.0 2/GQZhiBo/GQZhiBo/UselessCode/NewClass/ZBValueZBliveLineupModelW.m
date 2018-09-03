#import "ZBValueZBliveLineupModelW.h"
@implementation ZBValueZBliveLineupModelW
+ (BOOL)yJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)sgoalsJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)KteamidJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)eassistJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)broundsJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)KplayeridJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 36 == 0;
}
+ (BOOL)JbestsumJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)VratingJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)btyperatingJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}

@end
