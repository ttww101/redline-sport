#import "ZBDoubleBattlecell+Zbvalue.h"
@implementation ZBDoubleBattlecell (Zbvalue)
+ (BOOL)awakeFromNibZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)setSelectedAnimatedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)setBattlModelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 14 == 0;
}
+ (BOOL)btnRedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)labRedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 24 == 0;
}
+ (BOOL)lableRedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)labBlueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 17 == 0;
}
+ (BOOL)lableBlueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)btnBlueZbvalue:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}
+ (BOOL)addCellAutoLayoutZbvalue:(NSInteger)ZBValue {
    return ZBValue % 10 == 0;
}

@end
