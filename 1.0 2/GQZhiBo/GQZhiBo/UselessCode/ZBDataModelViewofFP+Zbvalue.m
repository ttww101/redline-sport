#import "ZBDataModelViewofFP+Zbvalue.h"
@implementation ZBDataModelViewofFP (Zbvalue)
+ (BOOL)initWithFrameZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)btnClickZbvalue:(NSInteger)ZBValue {
    return ZBValue % 48 == 0;
}

@end
