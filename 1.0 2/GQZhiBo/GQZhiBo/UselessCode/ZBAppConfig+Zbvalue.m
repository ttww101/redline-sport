#import "ZBAppConfig+Zbvalue.h"
@implementation ZBAppConfig (Zbvalue)
+ (BOOL)shareInstanceZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)initializeZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}

@end
