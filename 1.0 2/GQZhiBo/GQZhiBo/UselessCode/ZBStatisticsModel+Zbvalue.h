#import "ZBBasicModel.h"
#import "ZBGoodPlayModel.h"
#import "ZBGoodsclassModel.h"
#import "ZBTuijiandatingModel.h"
#import "ZBTotalrateModel.h"
#import "ZBUsermarkModel.h"
#import "ZBMedalsModel.h"
#import "ZBStatisticsModel.h"

@interface ZBStatisticsModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue;
+ (BOOL)goodPlayJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)goodsclassJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)RecoommandmodelJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)arrTotalrateJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)arrUsertitleJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)medalsJSONTransformerZbvalue:(NSInteger)ZBValue;

@end
