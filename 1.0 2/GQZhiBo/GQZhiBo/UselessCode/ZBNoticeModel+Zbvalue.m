#import "ZBNoticeModel+Zbvalue.h"
@implementation ZBNoticeModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 5 == 0;
}

@end
