#import "ZBValueZBNewslistModelS.h"
@implementation ZBValueZBNewslistModelS
+ (BOOL)kJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}

@end
