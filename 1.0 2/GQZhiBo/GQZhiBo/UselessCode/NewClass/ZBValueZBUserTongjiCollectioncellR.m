#import "ZBValueZBUserTongjiCollectioncellR.h"
@implementation ZBValueZBUserTongjiCollectioncellR
+ (BOOL)fSetmodel:(NSInteger)ZBValue {
    return ZBValue % 44 == 0;
}
+ (BOOL)qmarkY:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)IlineView:(NSInteger)ZBValue {
    return ZBValue % 11 == 0;
}
+ (BOOL)EsetData:(NSInteger)ZBValue {
    return ZBValue % 38 == 0;
}
+ (BOOL)YChartvalueselectedeEntryQHighlight:(NSInteger)ZBValue {
    return ZBValue % 15 == 0;
}
+ (BOOL)DChartvaluenothingselected:(NSInteger)ZBValue {
    return ZBValue % 41 == 0;
}

@end
