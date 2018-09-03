#import "ZBValueZBUserTongjiModela.h"
@implementation ZBValueZBUserTongjiModela
+ (BOOL)rJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 32 == 0;
}
+ (BOOL)jgroupTimeStatisJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 20 == 0;
}

@end
