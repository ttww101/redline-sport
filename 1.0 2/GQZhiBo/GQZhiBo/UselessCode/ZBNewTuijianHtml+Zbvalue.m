#import "ZBNewTuijianHtml+Zbvalue.h"
@implementation ZBNewTuijianHtml (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)setSegIndexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)changIndexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}
+ (BOOL)delayMethodZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)loadZhiShuZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)scrollViewDidScrollZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}

@end
