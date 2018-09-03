#import "ZBValueZBTongPeiTJModele.h"
@implementation ZBValueZBTongPeiTJModele
+ (BOOL)LJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}

@end
