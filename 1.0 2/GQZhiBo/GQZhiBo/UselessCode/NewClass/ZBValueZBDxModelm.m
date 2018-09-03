#import "ZBValueZBDxModelm.h"
@implementation ZBValueZBDxModelm
+ (BOOL)sJSONKeyPathsByPropertyKey:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}
+ (BOOL)sDownOddsJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)KUpOddsJSONTransformer:(NSInteger)ZBValue {
    return ZBValue % 12 == 0;
}

@end
