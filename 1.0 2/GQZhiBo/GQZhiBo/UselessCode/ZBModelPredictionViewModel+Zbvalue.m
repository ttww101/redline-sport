#import "ZBModelPredictionViewModel+Zbvalue.h"
@implementation ZBModelPredictionViewModel (Zbvalue)
+ (BOOL)createModelListArrayZbvalue:(NSInteger)ZBValue {
    return ZBValue % 21 == 0;
}

@end
