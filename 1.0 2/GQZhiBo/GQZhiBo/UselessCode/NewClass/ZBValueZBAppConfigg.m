#import "ZBValueZBAppConfigg.h"
@implementation ZBValueZBAppConfigg
+ (BOOL)cshareInstance:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)Linitialize:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}

@end
