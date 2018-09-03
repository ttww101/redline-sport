#import "ZBValueZBHeaderControlY.h"
@implementation ZBValueZBHeaderControlY
+ (BOOL)BInitwithframeTContentQShowrightline:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)dSetcontent:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}

@end
