#import "ZBNewZhiBoWebView+Zbvalue.h"
@implementation ZBNewZhiBoWebView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}
+ (BOOL)changIndexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)loadDataZhiBoZbvalue:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)scrollViewDidScrollZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}

@end
