#import "ZBViewPagerController.h"
#import "ZBSelectedAllVC.h"
#import "ZBSelectedJincaiVC.h"
#import "ZBSelectedChupanVC.h"
#import "ZBBasicViewController.h"
@interface ZBSaishiSelecterdVC : ZBViewPagerController
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrDataJingcai;
@property (nonatomic, strong) NSArray *arrDataChupan;
@property (nonatomic, assign)NSInteger jincai;
@property (nonatomic) typeSaishiSelecterdVC type;
@property (nonatomic, strong) NSArray *arrBifenData;
@property (nonatomic, strong) NSArray *arrTuijianSelectedData;
@property (nonatomic, strong) NSArray *arrInfoSelectedData;
@end
