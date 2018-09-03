#import <Mantle/Mantle.h>
@interface ZBBasicModel : MTLModel<MTLJSONSerializing>
+ (id)entityFromDictionary:(NSDictionary *)data;
+ (NSArray *)arrayOfEntitiesFromArray:(NSArray *)array;
- (NSDictionary *)transformToDictionary;
+ (NSArray *)transformToArray:(NSArray *)array;
@end
