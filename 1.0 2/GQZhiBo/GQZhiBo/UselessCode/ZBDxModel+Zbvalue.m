#import "ZBDxModel+Zbvalue.h"
@implementation ZBDxModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)DownOddsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 42 == 0;
}
+ (BOOL)UpOddsJSONTransformerZbvalue:(NSInteger)ZBValue {
    return ZBValue % 47 == 0;
}

@end
