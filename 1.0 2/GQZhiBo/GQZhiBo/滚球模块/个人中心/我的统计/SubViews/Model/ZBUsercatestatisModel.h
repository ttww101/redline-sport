#import "ZBBasicModel.h"
#import "ZBStatisticsModel.h"
#import "ZBGoodPlayModel.h"
#import "ZBGoodsclassModel.h"
#import "ZBTotalrateModel.h"
#import "ZBStatisticsSectionTwoModel.h"
@interface ZBUsercatestatisModel : ZBBasicModel
@property (nonatomic, assign) NSInteger avgweeknum;
@property (nonatomic, strong) ZBStatisticsModel *userinfo;
@property (nonatomic, strong) ZBGoodPlayModel *goodplay;
@property (nonatomic, strong) ZBGoodsclassModel *goodsclass;
@property (nonatomic, strong) NSArray *totalrate;
@property (nonatomic, strong) NSArray *nearten;
@property (nonatomic, strong) NSArray *sclassStatis;
@property (nonatomic, strong) NSArray *playStatis0;
@property (nonatomic, strong) NSArray *playStatis1;
@property (nonatomic, strong) NSArray *ouPanStatis;
@property (nonatomic, strong) NSArray *playStatis2;
@property (nonatomic, strong) NSArray *yaPanStatis;
@property (nonatomic, strong) NSArray *playStatis3;
@property (nonatomic, strong) NSArray *dxPanStatis;
@property (nonatomic, strong) NSArray *timeStatis;
@property (nonatomic, strong) NSArray *monthGroup;
@property (nonatomic, strong) NSArray *weekGroup;
@end
