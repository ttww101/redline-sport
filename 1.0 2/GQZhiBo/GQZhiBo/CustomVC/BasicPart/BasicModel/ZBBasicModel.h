//
//  ZBBasicModel.h
//  GunQiuLive
//
//  Created by WQ_h on 16/2/3.
//  Copyright © 2016年 WQ_h. All rights reserved.
//


/*
 model 里面套model的用法
 @property (nonatomic, strong) PankouModel *spf;
 @property (nonatomic, strong) NSArray *arrNews;
 
 + (NSValueTransformer *)spfJSONTransformer {
 return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[PankouModel class]];
 }
 + (NSValueTransformer *)arrNewsJSONTransformer
 {
 return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[FpNewsModel class]];
 
 }

 */
#import <Mantle/Mantle.h>

@interface ZBBasicModel : MTLModel<MTLJSONSerializing>

//请求过的字典解析
+ (id)entityFromDictionary:(NSDictionary *)data;
//请求过来的数组解析
+ (NSArray *)arrayOfEntitiesFromArray:(NSArray *)array;

- (NSDictionary *)transformToDictionary;
+ (NSArray *)transformToArray:(NSArray *)array;
@end
