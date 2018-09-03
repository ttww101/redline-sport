#import "ZBLiveEventMedel+Zbvalue.h"
@implementation ZBLiveEventMedel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}

@end
