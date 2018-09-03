#import "ZBValueZBPlycModelC.h"
@implementation ZBValueZBPlycModelC
+ (BOOL)SJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)EpanProcessJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}

@end
