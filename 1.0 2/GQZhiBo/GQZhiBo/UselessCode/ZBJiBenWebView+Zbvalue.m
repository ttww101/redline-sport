#import "ZBJiBenWebView+Zbvalue.h"
@implementation ZBJiBenWebView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)loadFenXiZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)loadTongjiTezhengZbvalue:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)scrollViewDidScrollZbvalue:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}

@end
