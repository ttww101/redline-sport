#import "ZBValueZBSelectedEventViewN.h"
@implementation ZBValueZBSelectedEventViewN
+ (BOOL)AUpdateselectedindex:(NSInteger)ZBValue {
    return ZBValue % 39 == 0;
}
+ (BOOL)gInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}
+ (BOOL)DviewPage:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}
+ (BOOL)kSetarrdata:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)lUpdateselected:(NSInteger)ZBValue {
    return ZBValue % 18 == 0;
}
+ (BOOL)SSetattentionnum:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}

@end
