#import "ZBValueZBLiveListModelh.h"
@implementation ZBValueZBLiveListModelh
+ (BOOL)vmodelCustomPropertyMapper:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}

@end
