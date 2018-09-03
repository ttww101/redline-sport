#import "ZBLiveListModel.h"
@implementation ZBLiveListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
}
@end
@implementation LiveListArrayModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"ZBLiveListModel") };
}
@end
