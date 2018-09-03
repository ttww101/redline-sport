#import "ZBVierticalScrollView+Zbvalue.h"
@implementation ZBVierticalScrollView (Zbvalue)
+ (BOOL)initWithArrayAndframeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)initWithTitleArrayAndframeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 19 == 0;
}
+ (BOOL)nextButtonZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)clickBtnZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}

@end
