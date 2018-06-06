//
//  BifenViewController.m
//  GunQiuLive
//
//  Created by WQ_h on 16/1/27.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "BifenViewController.h"
#import "LiveScoreModel.h"
#import "LivingModel.h"
#import "QiciModel.h"
#import "BifenSetingViewController.h"
#import "SearchMatchVC.h"
#import "SaishiSelecterdVC.h"
#import "BIfenSelectedSaishiModel.h"

#import "JishiViewController.h"
#import "SaiguoViewController.h"
#import "SaichengViewController.h"
#import "GuanzhuViewController.h"

#import "SelecterMatchView.h"

#import "SelectedEventView.h"

#import "HSTabBarContentView.h"
#import "ArchiveFile.h"
#import "GQWebView.h"

@interface BifenViewController ()<ViewPagerDataSource,ViewPagerDelegate,SelectedEventViewDelegate,NavViewDelegate,SelecterMatchViewDelegate,HSTabBarContentViewDelegate,HSTabBarContentViewDataSource, GQWebViewDelegate>
@property (nonatomic, strong)JishiViewController *jishiVC;
@property (nonatomic, strong)SaiguoViewController *saiguoVC;
@property (nonatomic, strong)SaichengViewController *saichengVC;
@property (nonatomic, strong)GuanzhuViewController *guanzhuVC;
@property (nonatomic, strong) SelectedEventView*TitleView;
@property (nonatomic, strong) HSTabBarContentView       *navTitleView;
@property (nonatomic, strong) NSMutableArray            *titleArr;

//当前第几个页面
@property (nonatomic, assign)NSInteger currentIndex;
//当前选择全部竞彩，足彩北单中的哪一个
@property (nonatomic, assign)NSInteger currentflag;

//选择赛事里面全部的赛事数据
@property (nonatomic, strong) NSArray *arrSelectedSaishi;
//选择赛事里面竞彩的赛事数据
@property (nonatomic, strong) NSArray *arrSelectedSaishiJingcai;
//选择赛事里面初盘的赛事数据
@property (nonatomic, strong) NSArray *arrSelectedSaishiChupan;


@property (nonatomic, strong) SelecterMatchView *matchView;

@property (nonatomic, strong) UIButton *btnTitle;
@property (nonatomic, strong) UIButton *imageV;

@property (nonatomic , strong) UIImageView *activityImageView;

@property (nonatomic , strong) UIWebView *activityWeb;

@property (nonatomic , copy) NSDictionary *activityDic;


@end

@implementation BifenViewController


-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    //为了让进球动画只在即时比分这个页面显示，要在push进去的时候设置为NO，三个页面 筛选页面，设置页面，分析页
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showJinqiuAnimation"];
    
    self.navigationController.navigationBar.barTintColor = redcolor;
    self.navigationController.navigationBar.translucent = NO;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"screenSleep"]) {
        [UIApplication sharedApplication].idleTimerDisabled =YES;
        
    }else{
        [UIApplication sharedApplication].idleTimerDisabled =NO;
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"allbifen"]) {
        
        self.navTitleView.selectedIndex = 0 ;
//        [self.navTitleView realoadTabBar];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jingcaibifen"]) {
    
        self.navTitleView.selectedIndex = 1;
//        [self.navTitleView realoadTabBar];
    }
    
    //如果筛选之后返回，就不需要重新加载数据
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadedBifenData"]) {
        //    每次进入这个页面都默认加载最新的数据

    }
    
    [self loadRedBombActivity];
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

- (NSMutableArray *)titleArr {
    
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"全部",@"竞彩",@"北单",@"足彩", nil];
    }
    return _titleArr;
}

- (HSTabBarContentView *)navTitleView {
    
    if (!_navTitleView) {
        _navTitleView = [[HSTabBarContentView alloc] init];
        _navTitleView.delegate = self;
        _navTitleView.dataSource = self;
        _navTitleView.bottomLineHide = YES;
        _navTitleView.titleFont = 15;
    }
    return _navTitleView;
}

//- (void)setupMainCategories {
//    
//    [self.view addSubview:self.navTitleView];
//    [self.navTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
//    
//    }];
//    
//    [self.navTitleView reloadData];
//}

#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.height = 74;
    nav.delegate = self;
    nav.labTitle.text = @"";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"shezhiBifen1"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"shezhiBifen1"] forState:UIControlStateHighlighted];
   
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"shaixuanBifen1"] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"shaixuanBifen1"] forState:UIControlStateHighlighted];
    
    
    /*
    
    _btnTitle = [[UIButton alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myStateBar, 80, nav.btnLeft.height)];
    _btnTitle.center = CGPointMake(nav.labTitle.center.x - 15, nav.labTitle.center.y) ;
    _btnTitle.titleLabel.font = font18;
    [_btnTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnTitle setTitle:@"全部比分" forState:UIControlStateNormal];
    [_btnTitle addTarget:self action:@selector(selectedMatch) forControlEvents:UIControlEventTouchUpInside];
    nav.labTitle.hidden = YES;
    [nav addSubview:_btnTitle];
    
     
    _imageV = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageV.frame = CGRectMake(_btnTitle.right, 0, 30, 30);
    _imageV.center = CGPointMake(_imageV.center.x, _btnTitle.center.y);
    [_imageV setBackgroundImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
    [_imageV setBackgroundImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateHighlighted];
    [_imageV setBackgroundImage:[UIImage imageNamed:@"xialaSelected"]  forState:UIControlStateSelected];

    [_imageV addTarget:self action:@selector(selectedMatch) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:_imageV];
    
     */
    
    
    UIButton *btnShaixuan = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShaixuan.bounds = nav.btnRight.bounds;
    btnShaixuan.center = CGPointMake(nav.btnRight.center.x - nav.btnRight.width, nav.btnRight.center.y - 2);
    [btnShaixuan setBackgroundImage:[UIImage imageNamed:@"search1"] forState:UIControlStateNormal];
    [btnShaixuan setBackgroundImage:[UIImage imageNamed:@"search1"] forState:UIControlStateHighlighted];
    [btnShaixuan addTarget:self action:@selector(btnSearch) forControlEvents:UIControlEventTouchUpInside];
    
    [nav addSubview:btnShaixuan];
     
    
    
    [nav addSubview:self.navTitleView];
    [self.view addSubview:nav];
//    [nav insertSubview:self.navTitleView atIndex:1];
    
    [self.navTitleView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.leading.equalTo(nav.btnLeft.mas_trailing).offset(5);
        make.trailing.equalTo(btnShaixuan.mas_leading).offset(-5);
        make.centerY.equalTo(nav.btnRight).offset(8);
        make.height.equalTo(nav.btnRight);
    }];
    [self.navTitleView reloadData];
    
    
    
//    [[APPDELEGATE window] addSubview:self.navTitleView];
//    [[APPDELEGATE window] addSubview:self.matchView];
    
//    _matchView.arrData = @[@"全部比分",@"竞彩比分",@"北单比分",@"足彩比分"];
    
}

- (void)btnSearch
{
    
//    if (!_matchView.hidden) {
//        [UIView animateWithDuration:0.5 animations:^{
//            _matchView.alpha = 0;
//        }completion:^(BOOL finished) {
//            _matchView.hidden = YES;
//            _imageV.selected = NO;
//            
//        }];
//        return;
//    }
    
    //        搜索
    
    SearchMatchVC *searchVC = [[SearchMatchVC alloc] init];
    searchVC.arrAlldata = self.jishiVC.memeryArrAllPart;
    searchVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:searchVC animated:YES];
    
    
}


#pragma mark - HSTabBarContentViewDelegate -
//- (CGFloat)heightForTabBarInTabBarContentView:(HSTabBarContentView *)tabBarContentView {
//    
//    return nil;
//}

- (UIColor *)colorForTabBarItemTextInTabBarContentView:(HSTabBarContentView *)tabBarContentView {
    
    return colorFFD8D6;
}

- (UIColor *)highlightColorForTabBarItemInTabBarContentView:(HSTabBarContentView *)tabBarContentView {

    return colorFFFFFF;
}

- (UIView *)highlightViewForTabBarItemInTabBarContentView:(HSTabBarContentView *)tabBarContentView {

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

- (void)tabBarContentView:(HSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index {

//    NSLog(@"%zd",index);
//    self.navTitleView.titleFlag = index + 1;
//        [self.navTitleView addObserver:self forKeyPath:@"titleFlag" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"allbifen"]) {
//        
//        [self SelecterMatchView:nil selectedAtIndex:1];
//    }else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jingcaibifen"]) {
//        
//        [self SelecterMatchView:nil selectedAtIndex:2];
//    }else{
//    
//        [self SelecterMatchView:nil selectedAtIndex:index];
//    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"_currentflag"];

    NSDictionary *bifenDic = [[NSDictionary alloc] initWithObjectsAndKeys:@(index + 1),@"bifenTitleFlag", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:biFenTitleChange object:@"biFenChange" userInfo:bifenDic];
    [self SelecterMatchView:nil selectedAtIndex:index];
//    [self didSelectedAtIndex:0];
}


#pragma mark - HSTabBarContentViewDataSource -
- (NSInteger)numberOfItemsInTabBarContentView:(HSTabBarContentView *)tabBarContentView {
    
    return self.titleArr.count;
}

- (NSString *)tabBarContentView:(HSTabBarContentView *)tabBarContentView titleForItemAtIndex:(NSInteger)index {

    return [NSString stringWithFormat:@"%@",self.titleArr[index]];;
}

- (UIView *)tabBarContentView:(HSTabBarContentView *)tabBarContentView contentViewAtIndex:(NSInteger)index {

 
    
    return nil;
}


#pragma mark - matchView -
- (void)navViewTouchAnIndex:(NSInteger)index
{
    
//    if (!_matchView.hidden) {
//        [UIView animateWithDuration:0.5 animations:^{
//            _matchView.alpha = 0;
//        }completion:^(BOOL finished) {
//            _matchView.hidden = YES;
//            _imageV.selected = NO;
//
//        }];
//        return;
//    }
    
    if (index == 1) {
        
//        NSLog(@"%zd",index);
        //设置页面不显示进球动画
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showJinqiuAnimation"];
        
        BifenSetingViewController *biFenSetVC = [[BifenSetingViewController alloc] init];
        biFenSetVC.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:biFenSetVC animated:YES];
    }else if(index == 2){
    
        
//        NSLog(@"%zd",index);
        
//            if (!_matchView.hidden) {
//                [UIView animateWithDuration:0.5 animations:^{
//                    _matchView.alpha = 0;
//                }completion:^(BOOL finished) {
//                    _matchView.hidden = YES;
//                    _imageV.selected = NO;
//
//                }];
//                return;
//            }
//            
        
//            //北单没筛选
//            if (_currentflag == 3) {
//                return;
//            }
//            //    关注没有筛选
//            if (_currentIndex == 3) {
//                return;
//            }
//            
        
            //筛选页面不显示进球动画
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showJinqiuAnimation"];
            
            SaishiSelecterdVC *selectedVC = [[SaishiSelecterdVC alloc] init];
            selectedVC.type = typeSaishiSelecterdVCBifen;
            
            
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
            
            
            
            
            
            selectedVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:selectedVC animated:YES];
            
            
            
        
        
    }
}



- (void)selectedMatch
{
    [self showOrhideMatchView];
    
}
- (SelecterMatchView *)matchView
{
    if (!_matchView) {
        _matchView = [[SelecterMatchView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
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
- (void)SelecterMatchView:(SelecterMatchView *)matchView selectedAtIndex:(NSInteger)index
{
    
//    切换赛事可以刷新
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didSelectedbifen"];

  /*
    
    NSArray *arr = @[@"全部比分",@"竞彩比分",@"北单比分",@"足彩比分",];
    [_btnTitle setTitle:[NSString stringWithFormat:@"%@",[arr objectAtIndex:index]] forState:UIControlStateNormal];
    [self showOrhideMatchView];
    
   */
    
    // 这个是为有的地方需要反转写的
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"_currentflag"];
//    NSLog(@"_currentflag -----%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"_currentflag"]);
//    if (_currentflag  == index) {
//        
//    }else{
    
        _currentflag = index;
    
        
        [self.jishiVC refreshDataByChangeFlag:_currentflag];
        [self.saiguoVC refreshDataByChangeFlag:_currentflag];
        [self.saichengVC refreshDataByChangeFlag:_currentflag];
//    }
    
//    [self didSelectedAtIndex:0];
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
    // Do any additional setup after loading the view.
    //        self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TitleView];
    
    self.delegate = self;
    self.dataSource = self;
    self.manualLoadData = NO;
    self.currentIndex = 0;
    self.scrollingLocked = YES;
    
    [self reloadData];
    [self setNavView];
    
    //没有筛选过，可以刷新数据，筛选过之后就不能在刷新数据了，每次出初始化的时候甚至为NO
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didSelectedbifen"];

    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settableViewContentOffsetZero) name:NotificationsetSecondTableViewContentOffsetZero object:nil];
    //关注的比赛
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(attentionClick) name:@"attentionClick" object:nil];
    
    //筛选之后重新加载视图时的数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateByselectedsaishi:) name:NotificationupdateByselectedSaishi object:nil];
    //是否显示竞彩编号
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWhetherShowSort) name:@"NSNotificationCenterupdateWhetherShowSort" object:nil];

    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",0] forKey:@"_currentflag"];

    NSArray *arrviewcontroller = @[self.jishiVC,self.saiguoVC,self.saichengVC,self.guanzhuVC];
    NSLog(@"%@",arrviewcontroller);
    [self getAttentionNum];
}
- (void)updateWhetherShowSort
{
    [self.jishiVC.tableView reloadData];
    [self.saiguoVC.tableView reloadData];
    [self.saichengVC.tableView reloadData];
    [self.guanzhuVC.tableView reloadData];
}
- (void)attentionClick{

    [self getAttentionNum];
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


- (SelectedEventView *)TitleView{
    if (!_TitleView) {
        _TitleView = [[SelectedEventView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar+10, Width, 44)];
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
    
    
    
    
}


#pragma  mark -- ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager
{
    return 4;
}

- (JishiViewController *)jishiVC
{
    if (!_jishiVC) {
        _jishiVC = [JishiViewController new];
    }
    return  _jishiVC;

}

- (SaiguoViewController *)saiguoVC
{
    if (!_saiguoVC) {
        _saiguoVC = [SaiguoViewController new];
    }
    return  _saiguoVC;

}

- (SaichengViewController *)saichengVC
{
    if (!_saichengVC) {
        _saichengVC = [SaichengViewController new];
    }
    return _saichengVC;

}
- (GuanzhuViewController *)guanzhuVC
{
    if (!_guanzhuVC) {
        _guanzhuVC = [GuanzhuViewController new];
    }
    return _guanzhuVC;

}
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
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

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
    //    _currentIndex = index;
    
    NSLog(@"%lu",(unsigned long)index);
}
// 切换VC
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    
    _currentIndex = currentIndex;
    [self.TitleView updateSelectedIndex:_currentIndex];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    //    NSLog(@"%f",scrollView.contentOffset.x);
    
    if (self.currentIndex != 0 && contentOffsetX <= Width * 4) {
        contentOffsetX += Width * self.currentIndex;
    }
    //        NSLog(@"%f",contentOffsetX);
    
    
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
//            筛选之后不能重新刷新
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
    
//    self.AlldataArrary = [notification.userInfo objectForKey:@"arrData"];
    
}
    
    
    
    
- (void)getAttentionNum
    {
        
        NSString *documentsPath = [Methods getDocumentsPath];
        NSString *arrayPath = [documentsPath stringByAppendingPathComponent:BifenPageAttentionArray];
        NSArray *arrAttentionMid = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:arrayPath]];
        
        
        if (arrAttentionMid.count == 0) {
            _TitleView.attentionNum = @"0";
            return;
        }
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
        //        [parameter setObject:@"2" forKey:@"flag"];
        NSString *ids = [arrAttentionMid componentsJoinedByString:@","];
        [parameter setObject:ids forKey:@"ids"];
        [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_bifen_focus] ArrayFile:nil Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                
                NSArray *arrAttention  = [[NSArray alloc] initWithArray:[LiveScoreModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"matchs"]]];
                
                NSMutableArray *arrMid = [NSMutableArray array];
                for (int i = 0; i<arrAttention.count; i++) {
                    LiveScoreModel *liveM = [arrAttention objectAtIndex:i];
                    [arrMid addObject:[NSString stringWithFormat:@"%ld",liveM.mid]];
                }
                //更新本地的关注内容
                [NSKeyedArchiver archiveRootObject:arrMid toFile:arrayPath];
                _TitleView.attentionNum = [NSString stringWithFormat:@"%ld",arrAttention.count];


            }else{
                

            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {

        }];
}


    
    
    

- (void)stay
{
    //将筛选里面记录的赛事清除
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
    NSString *documentPath = [Methods getDocumentsPath];
    NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
    
    NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
    
    NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
    

    
//    _arrSelectedSaishi = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"allindex"]]];
//    _arrSelectedSaishiJingcai = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"jcindex"]]];
//    _arrSelectedSaishiChupan = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"oddsindex"]]];
//    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    [self removeObserver:self.navTitleView forKeyPath:@"titleFlag"];
}

#pragma mark -  活动入口

#pragma mark - GQWebViewDelegate

- (void)webClose:(id)data {
    if (_activityWeb) {
        [_activityWeb removeFromSuperview];
        _activityWeb = nil;
    }
}

- (void)loadRedBombActivity {
    if (!_activityImageView) {
        [self.view addSubview:self.activityImageView];
    }
    NSMutableArray *activityArray = [ArchiveFile getDataWithPath:Activity_Path];
    for (NSDictionary *dic in activityArray) {
        if (dic[@"redBomb"]) {
            NSDictionary *itemDic = dic[@"redBomb"];
            self.activityDic = itemDic;
            [self.activityImageView sd_setImageWithURL:[NSURL URLWithString:itemDic[@"icon"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.activityImageView.hidden = false;
            });
            break;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.activityImageView.hidden = YES;
            });
        }
    }
}

#pragma mark - Events

- (void)redBombActivity:(UIGestureRecognizer *)tap {
    if (self.activityDic) {
        WebModel *model = [[WebModel alloc]init];
        model.title = PARAM_IS_NIL_ERROR(self.activityDic[@"title"]);
        model.webUrl = PARAM_IS_NIL_ERROR(self.activityDic[@"url"]);
        //    model.webUrl = @"http://mobiledev.gunqiu.com:81/appH5/red-envelopes.html";
        model.hideNavigationBar = YES;
        GQWebView *web = [[GQWebView alloc]init];
        web.webDelegate = self;
        web.frame = [UIScreen mainScreen].bounds;
        web.model = model;
        web.opaque = NO;
        web.backgroundColor = [UIColor clearColor];
        web.scrollView.scrollEnabled = false;
        [[Methods getMainWindow] addSubview:web];
        _activityWeb = web;
    }
}

#pragma mark - Lazy Load

- (UIImageView *)activityImageView {
    if (_activityImageView == nil) {
        _activityImageView = [UIImageView new];
        _activityImageView.frame = CGRectMake(0, 118, Width, 44);
        _activityImageView.contentMode = UIViewContentModeScaleAspectFill;
        _activityImageView.clipsToBounds = YES;
        _activityImageView.hidden = YES;
        _activityImageView.backgroundColor = [UIColor orangeColor];
        _activityImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(redBombActivity:)];
        [_activityImageView addGestureRecognizer:tap];
    }
    return _activityImageView;
}

@end
