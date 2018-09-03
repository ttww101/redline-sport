#import "ZBValueZBLivingModele.h"
@implementation ZBValueZBLivingModele
+ (BOOL)EJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}

@end
