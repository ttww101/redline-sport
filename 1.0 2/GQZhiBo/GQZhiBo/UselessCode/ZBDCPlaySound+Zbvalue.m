#import "ZBDCPlaySound+Zbvalue.h"
@implementation ZBDCPlaySound (Zbvalue)
+ (BOOL)initWithForPlayingVibrateZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)initWithForPlayingSystemSoundEffrctWithOftypeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)initWithForPlayingSoundEffectWithOftypeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)playZbvalue:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}
+ (BOOL)deallocZbvalue:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}

@end
