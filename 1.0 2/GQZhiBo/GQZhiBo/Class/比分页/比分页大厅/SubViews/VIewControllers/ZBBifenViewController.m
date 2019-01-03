#import "ZBBifenViewController.h"
#import "ZBLiveScoreModel.h"
#import "ZBLivingModel.h"
#import "ZBQiciModel.h"
#import "ZBBifenSetingViewController.h"
#import "ZBSearchMatchVC.h"
#import "ZBSaishiSelecterdVC.h"
#import "ZBBIfenSelectedSaishiModel.h"
#import "ZBJishiViewController.h"
#import "ZBSaiguoViewController.h"
#import "ZBSaichengViewController.h"
#import "ZBGuanzhuViewController.h"
#import "ZBSelecterMatchView.h"
#import "ZBSelectedEventView.h"
#import "ZBHSTabBarContentView.h"
#import "ArchiveFile.h"
#import "GeneralFloatingView.h"

@interface ZBBifenViewController ()<ViewPagerDataSource,ViewPagerDelegate,SelectedEventViewDelegate,NavViewDelegate,SelecterMatchViewDelegate,HSTabBarContentViewDelegate, GeneralFloatingViewDelegate>
@property (nonatomic, strong)ZBJishiViewController *jishiVC;
@property (nonatomic, strong)ZBSaiguoViewController *saiguoVC;
@property (nonatomic, strong)ZBSaichengViewController *saichengVC;
@property (nonatomic, strong)ZBGuanzhuViewController *guanzhuVC;
@property (nonatomic, strong) ZBSelectedEventView*TitleView;
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, assign)NSInteger currentflag;
@property (nonatomic, strong) NSArray *arrSelectedSaishi;
@property (nonatomic, strong) NSArray *arrSelectedSaishiJingcai;
@property (nonatomic, strong) NSArray *arrSelectedSaishiChupan;
@property (nonatomic, strong) ZBSelecterMatchView *matchView;
@property (nonatomic, strong) UIButton *btnTitle;
@property (nonatomic, strong) UIButton *imageV;

@property (nonatomic , strong) GeneralFloatingView *floatingView;

@end
@implementation ZBBifenViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSData *launchOptionPushInfoData =[[NSUserDefaults standardUserDefaults] objectForKey:@"launchOptionPushInfo"];
    if (launchOptionPushInfoData) {
        NSDictionary *launchOptionPushInfo = [NSDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:launchOptionPushInfoData]];
        if (launchOptionPushInfo.allValues.count>0) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"launchOptionPushInfo"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationpushToNewsWeb object:nil userInfo:launchOptionPushInfo];
        }
    }
}

#pragma mark - Config UI

- (void)configUI {
    [self.view addSubview:self.floatingView];
}

- (GeneralFloatingView *)floatingView {
    if (_floatingView == nil) {
        _floatingView = [[GeneralFloatingView alloc]initWithImages:@[@"filter"] scale:0.8 ignoreTabBar:false];
        _floatingView.delegate = self;
    }
    return _floatingView;
}

#pragma mark - GeneralFloatingViewDelegate

- (void)floatingViewDidSelected:(NSInteger)sender {
    if (self.currentIndex == 3) {
        [SVProgressHUD showErrorWithStatus:@"关注不可筛选"];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showJinqiuAnimation"];
    ZBSaishiSelecterdVC *selectedVC = [[ZBSaishiSelecterdVC alloc] init];
    selectedVC.type = typeSaishiSelecterdVCBifen;
    if (self.currentIndex == 0) {
        selectedVC.timeline = @"live";
         selectedVC.filterParameters = _jishiVC.filterParameters;
    } else if (self.currentIndex == 1) {
        selectedVC.timeline = @"old";
        selectedVC.date = _saiguoVC.date;
        selectedVC.filterParameters = _saiguoVC.filterParameters;
    }  else if (self.currentIndex == 2) {
        selectedVC.timeline = @"new";
        selectedVC.date = _saichengVC.date;
        selectedVC.filterParameters = _saichengVC.filterParameters;
    }
    [self.navigationController pushViewController:selectedVC animated:true];
}

#pragma mark - ************  分割  ************


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showJinqiuAnimation"];
    self.navigationController.navigationBar.barTintColor = redcolor;
    self.navigationController.navigationBar.translucent = NO;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"screenSleep"]) {
        [UIApplication sharedApplication].idleTimerDisabled =YES;
    }else{
        [UIApplication sharedApplication].idleTimerDisabled =NO;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        _matchView.alpha = 0;
    }completion:^(BOOL finished) {
        _matchView.hidden = YES;
        _imageV.selected = NO;
    }];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark -- setnavView
- (void)setNavView
{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.height = 74;
    nav.delegate = self;
    nav.labTitle.text = @"滚球体育";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"bifen_top_setting"] forState:UIControlStateNormal];
    nav.btnLeft.frame =  CGRectMake(15, 30, 20, 30);

    UIButton *btnShaixuan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShaixuan.bounds = nav.btnRight.bounds;
    btnShaixuan.center = CGPointMake(nav.btnRight.center.x, nav.btnRight.center.y - 2);
    [btnShaixuan setBackgroundImage:[UIImage imageNamed:@"bifen_top_search"] forState:UIControlStateNormal];
    [btnShaixuan addTarget:self action:@selector(btnSearch) forControlEvents:UIControlEventTouchUpInside];
    btnShaixuan.imageView.contentMode  = UIViewContentModeScaleAspectFit;
     btnShaixuan.frame =  CGRectMake(Width - 15 - 20, 30, 20, 30);
    [nav addSubview:btnShaixuan];
    
//    [nav addSubview:self.navTitleView];
    
    [self.view addSubview:nav];
    
//    [self.navTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(nav.btnLeft.mas_trailing).offset(5);
//        make.trailing.equalTo(btnShaixuan.mas_leading).offset(-5);
//        make.centerY.equalTo(nav.btnRight).offset(8);
//        make.height.equalTo(nav.btnRight);
//    }];
//    [self.navTitleView reloadData];
}
- (void)btnSearch
{
    ZBSearchMatchVC *searchVC = [[ZBSearchMatchVC alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:searchVC animated:YES];
}
#pragma mark - HSTabBarContentViewDelegate -
- (UIColor *)colorForTabBarItemTextInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView {
    return colorFFD8D6;
}
- (UIColor *)highlightColorForTabBarItemInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView {
    return colorFFFFFF;
}
- (UIView *)highlightViewForTabBarItemInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView {
    UIView *view = [UIView new];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor whiteColor];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view);
        make.trailing.mas_equalTo(view).offset(-10);
        make.leading.mas_equalTo(view).offset(10);
        make.height.mas_equalTo(2);
    }];
    return view;
}
- (void)tabBarContentView:(ZBHSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"_currentflag"];
    NSDictionary *bifenDic = [[NSDictionary alloc] initWithObjectsAndKeys:@(index + 1),@"bifenTitleFlag", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:biFenTitleChange object:@"biFenChange" userInfo:bifenDic];
    [self ZBSelecterMatchView:nil selectedAtIndex:index];
}


#pragma mark - matchView -
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showJinqiuAnimation"];
        ZBBifenSetingViewController *biFenSetVC = [[ZBBifenSetingViewController alloc] init];
        biFenSetVC.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:biFenSetVC animated:YES];
    }else if(index == 2){
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showJinqiuAnimation"];
            ZBSaishiSelecterdVC *selectedVC = [[ZBSaishiSelecterdVC alloc] init];
            selectedVC.type = typeSaishiSelecterdVCBifen;
        /*
            switch (_currentIndex) {
                case 0:
                {
                    selectedVC.arrData =self.jishiVC.arrSelectedSaishi;
                    selectedVC.arrDataJingcai =self.jishiVC.arrSelectedSaishiJingcai;
                    selectedVC.arrDataChupan =self.jishiVC.arrSelectedSaishiChupan;
                    selectedVC.arrBifenData = self.jishiVC.memeryArrAllPart;
                }
                    break;
                case 1:
                {
                    selectedVC.arrData =self.saiguoVC.arrSelectedSaishi;
                    selectedVC.arrDataJingcai =self.saiguoVC.arrSelectedSaishiJingcai;
                    selectedVC.arrDataChupan =self.saiguoVC.arrSelectedSaishiChupan;
                    selectedVC.arrBifenData = self.saiguoVC.memeryArrAllPart;
                }
                    break;
                case 2:
                {
                    selectedVC.arrData =self.saichengVC.arrSelectedSaishi;
                    selectedVC.arrDataJingcai =self.saichengVC.arrSelectedSaishiJingcai;
                    selectedVC.arrDataChupan =self.saichengVC.arrSelectedSaishiChupan;
                    selectedVC.arrBifenData = self.saichengVC.memeryArrAllPart;
                }
                    break;
                default:
                    break;
            }
         
         */
            selectedVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:selectedVC animated:YES];
    }
}
- (void)selectedMatch
{
    [self showOrhideMatchView];
}
- (ZBSelecterMatchView *)matchView
{
    if (!_matchView) {
        _matchView = [[ZBSelecterMatchView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
        _matchView.hidden = YES;
        _matchView.alpha = 0;
        _matchView.delegate = self;
    }
    return _matchView;
}
- (void)touchTapView
{
    [self showOrhideMatchView];
}
- (void)ZBSelecterMatchView:(ZBSelecterMatchView *)matchView selectedAtIndex:(NSInteger)index
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didSelectedbifen"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"_currentflag"];
        _currentflag = index;
        [self.jishiVC refreshDataByChangeFlag:_currentflag];
        [self.saiguoVC refreshDataByChangeFlag:_currentflag];
        [self.saichengVC refreshDataByChangeFlag:_currentflag];
    if (index == 0) {
        [MobClick event:@"quanbu" label:@""];
    } else if (index == 1) {
        [MobClick event:@"jingcai" label:@""];
    } else if (index == 2) {
        [MobClick event:@"beidan" label:@""];
    } else if (index == 3) {
        [MobClick event:@"zucai" label:@""];
    }
}
- (void)showOrhideMatchView
{
    if (_matchView.hidden) {
        _matchView.hidden = NO;
        _imageV.selected = YES;
        [UIView animateWithDuration:0.5 animations:^{
            _matchView.alpha = 1;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _matchView.alpha = 0;
        }completion:^(BOOL finished) {
            _matchView.hidden = YES;
            _imageV.selected = NO;
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TitleView];
    self.delegate = self;
    self.dataSource = self;
    self.manualLoadData = NO;
    self.currentIndex = 0;
    self.scrollingLocked = YES;
    [self reloadData];
    [self setNavView];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didSelectedbifen"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settableViewContentOffsetZero) name:NotificationsetSecondTableViewContentOffsetZero object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateByselectedsaishi:) name:NotificationupdateByselectedSaishi object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWhetherShowSort) name:@"NSNotificationCenterupdateWhetherShowSort" object:nil];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"_currentflag"];
    NSArray *arrviewcontroller = @[self.jishiVC,self.saiguoVC,self.saichengVC,self.guanzhuVC];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAttentionNum:) name:@"attentionNum" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadAttention" object:nil];
    [self configUI];
}
- (void)updateWhetherShowSort
{
    [self.jishiVC.tableView reloadData];
    [self.saiguoVC.tableView reloadData];
    [self.saichengVC.tableView reloadData];
    [self.guanzhuVC.tableView reloadData];
}

- (void)settableViewContentOffsetZero
{
    switch (_currentIndex) {
        case 0:
        {
            if (self.jishiVC.tableView.contentOffset.y != 0) {
                [self.jishiVC.tableView setContentOffset:CGPointZero animated:YES];
            }
        }
            break;
        case 1:
        {
            if (self.saiguoVC.tableView.contentOffset.y != 0) {
                [self.saiguoVC.tableView setContentOffset:CGPointZero animated:YES];
            }
        }
            break;
        case 2:
        {
            if (self.saichengVC.tableView.contentOffset.y!= 0) {
                [self.saichengVC.tableView setContentOffset:CGPointZero animated:YES];
            }
        }
            break;
        case 3:
        {
            if (self.guanzhuVC.tableView.contentOffset.y!= 0) {
                [self.guanzhuVC.tableView setContentOffset:CGPointZero animated:YES];
            }
        }
            break;
        default:
            break;
    }
}
- (ZBSelectedEventView *)TitleView{
    if (!_TitleView) {
        _TitleView = [[ZBSelectedEventView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar+10, Width, 44)];
            _TitleView.arrData = @[@"即时",@"赛果",@"赛程",@"关注"];
        _TitleView.delegate = self;
        _TitleView.selectedIndex = 0;
    }
    return _TitleView;
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    UIPageViewControllerNavigationDirection direction;
    if (index < _currentIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }else{
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    UIViewController *viewController = [self viewControllerAtIndex:index];
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = index;
        }];
    }
    if (index == 0) {
        [MobClick event:@"jishi" label:@""];
    } else if (index == 1) {
        [MobClick event:@"saiguo" label:@""];
    } else if (index == 2) {
        [MobClick event:@"saicheng" label:@""];
    } else if (index == 3) {
        [MobClick event:@"guanzhu" label:@""];
    }
}
#pragma  mark -- ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ZBViewPagerController *)viewPager
{
    return 4;
}
- (ZBJishiViewController *)jishiVC
{
    if (!_jishiVC) {
        _jishiVC = [ZBJishiViewController new];
    }
    return  _jishiVC;
}
- (ZBSaiguoViewController *)saiguoVC
{
    if (!_saiguoVC) {
        _saiguoVC = [ZBSaiguoViewController new];
    }
    return  _saiguoVC;
}
- (ZBSaichengViewController *)saichengVC
{
    if (!_saichengVC) {
        _saichengVC = [ZBSaichengViewController new];
    }
    return _saichengVC;
}
- (ZBGuanzhuViewController *)guanzhuVC
{
    if (!_guanzhuVC) {
        _guanzhuVC = [ZBGuanzhuViewController new];
    }
    return _guanzhuVC;
}

- (UIViewController *)viewPager:(ZBViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
        {
            return self.jishiVC;
        }
            break;
        case 1:
        {
            return self.saiguoVC;
        }
            break;
        case 2:
        {
            return self.saichengVC;
        }
            break;
        case 3:
        {
            return self.guanzhuVC;
        }
            break;
        default:
            break;
    }
    return nil;
}
#pragma  mark -- ViewPagerDelegate
- (void)viewPager:(ZBViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
    NSLog(@"%lu",(unsigned long)index);
}
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    if (_currentIndex == 3) {
        self.floatingView.hidden = true;
    } else {
        self.floatingView.hidden = false;
    }
    [self.TitleView updateSelectedIndex:_currentIndex];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (self.currentIndex != 0 && contentOffsetX <= Width * 4) {
        contentOffsetX += Width * self.currentIndex;
    }
    
    
}

- (void)scrollEnabled:(BOOL)enabled {
    self.scrollingLocked = !enabled;
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.scrollEnabled = enabled;
            view.bounces = enabled;
        }
    }
}

- (void)updateByselectedsaishi:(NSNotification *)notification
{
    switch (_currentIndex) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didSelectedbifen"];
            self.jishiVC.arrData = [NSMutableArray arrayWithArray:[notification.userInfo objectForKey:@"arrData"]];
            [self.jishiVC.tableView reloadData];
        }
            break;
        case 1:
        {
            self.saiguoVC.arrData = [NSMutableArray arrayWithArray:[notification.userInfo objectForKey:@"arrData"]];
            [self.saiguoVC.tableView reloadData];
        }
            break;
        case 2:
        {
            self.saichengVC.arrData = [NSMutableArray arrayWithArray:[notification.userInfo objectForKey:@"arrData"]];
            [self.saichengVC.tableView reloadData];
        }
            break;
        default:
            break;
    }
}

- (void)getAttentionNum:(NSNotification *)notifi {
    _TitleView.attentionNum = notifi.userInfo[@"num"];
    
}
- (void)stay
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
    NSString *documentPath = [ZBMethods getDocumentsPath];
    NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
    NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
    NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
