#import "ZBshowVideoView+Zbvalue.h"
@implementation ZBshowVideoView (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)setNavViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)configUIZbvalue:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)setUrlZbvalue:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)webViewDidStartLoadZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)webViewDidFinishLoadZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)webViewDidfailloadwitherrorZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)closeActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)reloadActionZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)webViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}

@end
