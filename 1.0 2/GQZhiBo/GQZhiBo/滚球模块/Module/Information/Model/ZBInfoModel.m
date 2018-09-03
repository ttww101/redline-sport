#import "ZBInfoModel.h"
@implementation ZBInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"InfoGroupModel") };
}
@end
@implementation InfoGroupModel
@end
