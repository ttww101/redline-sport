#import "UIAlertController+askForUserZbvalue.h"
@implementation UIAlertController (askForUserZbvalue)
+ (BOOL)showWithtitleMessageSureZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)getNavigationVcZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)showWithtitleTargrtMessageSureZbvalue:(NSInteger)ZBValue {
    return ZBValue % 49 == 0;
}
+ (BOOL)showWithtitleTargrtMessageSuretitleCanceltitleSureCancleZbvalue:(NSInteger)ZBValue {
    return ZBValue % 35 == 0;
}

@end
