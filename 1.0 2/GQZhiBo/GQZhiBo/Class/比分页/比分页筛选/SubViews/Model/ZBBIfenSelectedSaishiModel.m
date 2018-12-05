#import "ZBBIfenSelectedSaishiModel.h"
@implementation ZBBIfenSelectedSaishiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"count" : @"count",
             @"idId" : @"id",
             @"index" : @"index",
             @"name" : @"name",
             @"order" : @"order",
             @"tag" : @"tag",
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idId" : @"id",
             @"isSelected" : @"selected",
             };
}


@end

@implementation FilterModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"hot_items" : NSClassFromString(@"ZBBIfenSelectedSaishiModel"),
             @"other_items" : NSClassFromString(@"ZBBIfenSelectedSaishiModel"),
             @"items" : NSClassFromString(@"ZBBIfenSelectedSaishiModel")
             };
}


@end;

@implementation FilterData

@end;
