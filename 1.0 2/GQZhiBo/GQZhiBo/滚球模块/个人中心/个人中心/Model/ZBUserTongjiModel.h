#import "ZBBasicModel.h"
#import "ZBTotalrateModel.h"
@interface ZBUserTongjiModel : ZBBasicModel
@property (nonatomic, assign) NSInteger goNum;
@property (nonatomic, assign) NSInteger groupunit;
@property (nonatomic, assign) NSInteger loseNum;
@property (nonatomic, assign) NSInteger playType;
@property (nonatomic, assign) NSInteger totalNum;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger winNum;
@property (nonatomic, strong) NSString *profitRate;
@property (nonatomic, strong) NSString *winRate;
@property (nonatomic, strong) NSArray *goodPlays;
@property (nonatomic, strong) NSArray *goodSclass;
@property (nonatomic, strong) NSArray *groupTimeStatis;
@end
