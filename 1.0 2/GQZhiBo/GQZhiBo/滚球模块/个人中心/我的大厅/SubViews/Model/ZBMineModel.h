#import <Foundation/Foundation.h>
@interface ZBMineModel : NSObject
@property (nonatomic, copy) NSString *leftContent;
@property (nonatomic, copy) NSString *rightContent;
@property (nonatomic, copy) NSString *leftImageName;
@property (nonatomic, copy) NSString *rightImageName;
@end
@interface GQMineGroupModel : NSObject
@property (nonatomic, strong) NSMutableArray *groupArray;
@end
