#import "ZBWebviewProgressLine+Zbvalue.h"
@implementation ZBWebviewProgressLine (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)setLineColorZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}
+ (BOOL)startLoadingAnimationZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)endLoadingAnimationZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}

@end
