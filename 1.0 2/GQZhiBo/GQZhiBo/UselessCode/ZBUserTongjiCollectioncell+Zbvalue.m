#import "ZBUserTongjiCollectioncell+Zbvalue.h"
@implementation ZBUserTongjiCollectioncell (Zbvalue)
+ (BOOL)setModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 30 == 0;
}
+ (BOOL)markYZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}
+ (BOOL)lineViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}
+ (BOOL)setDataZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)chartValueSelectedEntryHighlightZbvalue:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)chartValueNothingSelectedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}

@end
