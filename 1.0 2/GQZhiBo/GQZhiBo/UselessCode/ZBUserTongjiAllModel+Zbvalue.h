#import "ZBBasicModel.h"
#import "ZBUserTongjiModel.h"
#import "ZBUserTongjiAllModel.h"

@interface ZBUserTongjiAllModel (Zbvalue)
+ (BOOL)JSONKeyPathsByPropertyKeyZbvalue:(NSInteger)ZBValue;
+ (BOOL)monthJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)allJSONTransformerZbvalue:(NSInteger)ZBValue;
+ (BOOL)weekJSONTransformerZbvalue:(NSInteger)ZBValue;

@end
