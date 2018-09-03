#import "ZBValueZBSucessViewOfSignatureViewp.h"
@implementation ZBValueZBSucessViewOfSignatureViewp
+ (BOOL)ZInitwithframe:(NSInteger)ZBValue {
    return ZBValue % 16 == 0;
}
+ (BOOL)BSucessback:(NSInteger)ZBValue {
    return ZBValue % 4 == 0;
}
+ (BOOL)Yimg:(NSInteger)ZBValue {
    return ZBValue % 40 == 0;
}
+ (BOOL)jlabSucc:(NSInteger)ZBValue {
    return ZBValue % 23 == 0;
}
+ (BOOL)jlabContent:(NSInteger)ZBValue {
    return ZBValue % 9 == 0;
}
+ (BOOL)jsubAotoMasnary:(NSInteger)ZBValue {
    return ZBValue % 13 == 0;
}

@end
