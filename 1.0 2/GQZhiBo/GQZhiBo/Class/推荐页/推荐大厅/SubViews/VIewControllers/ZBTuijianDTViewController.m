#import "ZBTuijianDTViewController.h"
#import "ZBSearchViewController.h"
#import "ZBBIfenSelectedSaishiModel.h"
#import "ZBFabuTuijianSelectedItemVC.h"
#import "ZBToAnalystsVC.h"
#import "ZBFaBuSucceedVCViewController.h"
#import "ZBPeiLvDetailVC.h"
#import "ZBJiShiPeiLvVC.h"
#import "ZBDoubleBattleVC.h"
@interface ZBTuijianDTViewController ()
 @end
@implementation ZBTuijianDTViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:YES];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 22, 22);
    [btn addTarget:self action:@selector(publishRecommend) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐大厅";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableViewV];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"tuijianDTShowProfit"];
    [self.tableViewV addSelectedView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSetConSize) name:@"tuijianSetSize" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewContentOffsetZero) name:NotificationsetForthTableViewContentOffsetZero object:nil];
}
- (void)setTableViewContentOffsetZero
{
    [self.tableViewV setContentOffset:CGPointZero animated:YES];
}
- (void)setSetConSize{
    [self.tableViewV setContentOffset:CGPointMake(0, 0)];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
    }else if(index == 2){
        ZBWebVC *webV = [[ZBWebVC alloc] init];
        webV.strtitle = @"推荐市场规则";
        webV.strurl=TUIJIAN_API_HTML;
        webV.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:webV animated:YES];
    }
}
- (ZBTuijianDatingTable *)tableViewV {
    if (!_tableViewV) {
        _tableViewV = [[ZBTuijianDatingTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain playType:_playType];
    }
    return _tableViewV;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Events
- (void)publishRecommend {
    if (![ZBMethods login]) {
        [ZBMethods toLogin];
        return;
    }
    ZBFabuTuijianSelectedItemVC *jinCai = [[ZBFabuTuijianSelectedItemVC alloc] init];
    jinCai.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:jinCai animated:YES];
}
@end
