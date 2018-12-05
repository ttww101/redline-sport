#import "ZBViewPagerController.h"
#import "ZBSelectedAllVC.h"
#import "ZBSelectedJincaiVC.h"
#import "ZBSelectedChupanVC.h"
#import "ZBBasicViewController.h"


UIKIT_EXTERN NSString *const FilterAllPageNotification;
UIKIT_EXTERN NSString *const FilterJingCaiPageNotification;
UIKIT_EXTERN NSString *const FilterZuCaiPageNotification;
UIKIT_EXTERN NSString *const FilterBeiDanPageNotification;


@interface ZBSaishiSelecterdVC : ZBViewPagerController
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrDataJingcai;
@property (nonatomic, strong) NSArray *arrDataChupan;
@property (nonatomic, assign)NSInteger jincai;
@property (nonatomic) typeSaishiSelecterdVC type;
@property (nonatomic, strong) NSArray *arrBifenData;
@property (nonatomic, strong) NSArray *arrTuijianSelectedData;
@property (nonatomic, strong) NSArray *arrInfoSelectedData;

@property (nonatomic , copy) NSString *timeline; // live 即时(默认)，old 赛果，new 赛程
@property (nonatomic , copy) NSString *date; //timeline 是live时 date 变量无效，赛程或赛果 传入具体的查询日期 2018-11-26

@end
