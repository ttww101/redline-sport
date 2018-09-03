#import "ZBBaolengDTHeaderView+Zbvalue.h"
@implementation ZBBaolengDTHeaderView (Zbvalue)
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}

@end
