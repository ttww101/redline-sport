#import "ZBLiveListModel+Zbvalue.h"
@implementation ZBLiveListModel (Zbvalue)
+ (BOOL)modelCustomPropertyMapperZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}

@end
