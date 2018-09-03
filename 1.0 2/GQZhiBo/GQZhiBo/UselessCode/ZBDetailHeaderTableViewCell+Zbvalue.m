#import "ZBDetailHeaderTableViewCell+Zbvalue.h"
@implementation ZBDetailHeaderTableViewCell (Zbvalue)
+ (BOOL)awakeFromNibZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)setSelectedAnimatedZbvalue:(NSInteger)ZBValue {
    return ZBValue % 3 == 0;
}

@end
