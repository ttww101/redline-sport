#import "ZBBasicModel.h"
#import "ZBDxModel.h"
#import "ZBPriceListModel.h"
#import "ZBDan_StringMatchsModel.h"

@interface ZBDan_StringMatchsModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue;
+ (BOOL)dxJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)priceListJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)rqJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)spfJSONTransformerZbvalue:(NSInteger)ZBValue;

@end
