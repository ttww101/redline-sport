#import "ZBValueZBDan_StringGuanModelM.h"
@implementation ZBValueZBDan_StringGuanModelM
+ (BOOL)fJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)lmatchsJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 26 == 0;
}

@end
