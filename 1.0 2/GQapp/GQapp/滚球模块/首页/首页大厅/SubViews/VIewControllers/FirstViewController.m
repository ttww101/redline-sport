//
//  FirstViewController.m
//  GQapp
//
//  Created by WQ_h on 16/3/28.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "FirstViewController.h"


#import "FocusModel.h"
#import "NewslistModel.h"
#import "FirstPInfoListModel.h"
#import "UserlistModel.h"
#import "RollInfoModel.h"


#import "TuijiandatingModel.h"
#import "WebDetailViewController.h"
#import "LoadHtmlStringVC.h"
#import "TuijianDatingCell.h"

#import "NewRecommandVC.h"

//#import "FirstPgHotInfoView.h"
#import "firstHotInfoCycleView.h"
#import "FirstPUserlistView.h"

//#import "QingBaoFPTwoModel.h"
#import "TuijianDetailVC.h"


#define cellFirstPageTuijian @"cellFirstPageTuijian"

#import "JiXianVC.h"//极限拐点
#import "BettingVC.h"//投注异常
#import "PanwangZhishuVC.h"//盘王指数
#import "JiaoYiViewController.h"//交易冷热
#import "BaolengZhishuVC.h"//爆冷指数
#import "TongpeiTongjiVC.h"//同赔指数
#import "PeilvYichangVC.h"//赔率异常
#import "YapanZhoushouVC.h"//亚盘助手

#import "VierticalScrollView.h"

#import "FenxiPageVC.h"

#import "TuijianDTViewController.h"


#import "LaunchView.h"
#import "GuideView.h"

#import "TodayHotSpotsCell.h"
#import "RedDanCycleView.h"

#import "TuijianDatingCell.h"
#import "TuijiandatingModel.h"

#import "RedDanModel.h"
#import "MostModel.h"
#import "LivingModel.h"

#import "DataModelView.h"

#import "TodayHotSpotsTwoCell.h"
#import "ModelPredictionViewController.h"
#import "ToolKitViewController.h"
#import "LiveViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,firstHotInfoCycleViewDelegate,FirstPUserlistViewDelegate,VierticalScrollViewDelegate,SDCycleScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,DataModelViewDelegate>

@property (nonatomic, strong) BasicTableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;

//四个网页地址
@property (nonatomic, strong) DataModelView *viewInfo;

//滚球信息滚动数据
@property (nonatomic, strong) NSArray *arrRollInfo;
//轮播图的数据
@property (nonatomic, strong) NSMutableArray *arrFocus;
//推荐数据
@property (nonatomic, strong) NSArray *arrRecommand;
//红单数据
@property (nonatomic, strong) NSArray *arrRedDan;


//情报数据
@property (nonatomic, strong) NSArray *arrInfolist;
// //专家推荐
//大咖
@property (nonatomic, strong) NSArray *arrUserListBigName;
//连红
@property (nonatomic, strong) NSArray *arrUserListRedList;
//胜率
@property (nonatomic, strong) NSArray *arrUserListWeekList;

@property (nonatomic, strong) NSArray *arrToHotzMost;

//最新资讯
@property (nonatomic, strong) NSArray *arrNewslist;
//最新话题
@property (nonatomic, strong) NewslistModel *column;

@property (nonatomic, strong)NSArray *hotRecommed;//热门推荐数据数组
//是否正在请求跳转分析页的接口
@property (nonatomic, assign) BOOL isToFenxi;

@property (nonatomic, strong) UIView *viewBar;
@property (nonatomic, strong)UITableViewCell *seleCell;

@property (nonatomic, strong)NSMutableArray *arrBtnUser;//推荐名人的按钮

@property (nonatomic, assign)NSInteger btnUerBtnIndex;

//@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong)firstHotInfoCycleView *firstPg;
//请求失败缓存都没有数据
@property (nonatomic, assign) BOOL nodata;

@property (nonatomic, assign) BOOL timerOn;


@property (nonatomic, strong) dispatch_source_t  timer;

@property (nonatomic , strong) UIImageView *liveQuizImageView;
@property (nonatomic , copy) NSString *href;


@end

@implementation FirstViewController



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"FirstViewController"];
    self.navigationController.navigationBarHidden = YES;
    [self changeTimer];
    //    _timerOn = YES;
    [self loadData];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadLiveData];
    });
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    //    _timerOn = NO;
    //    [self.timer setFireDate:[NSDate distantFuture]];
    dispatch_source_cancel(self.timer);
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)changeTimer {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(timer, ^{
        
        [self timerChange];
    });
    
    dispatch_resume(timer);
    
    self.timer = timer;
}



- (void)timerChange
{
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:[HttpString getCommenParemeter] PathUrlL:[NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_change] Start:^(id requestOrignal) {
        //        [_timer setFireDate:[NSDate distantFuture]];
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        NSArray *arrLiving = [LivingModel arrayOfEntitiesFromArray:responseOrignal];
        
        
        
        [self.firstPg setUpData:arrLiving];
        
        //        [self performSelector:@selector(startTime) withObject:nil afterDelay:5];
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        //        NSLog(@"%@",responseOrignal);
        //        [self performSelector:@selector(startTime) withObject:nil afterDelay:5];
        
    }];
}

//- (void)startTime
//{
//
//    if (_timerOn) {
//        [_timer setFireDate:[NSDate distantPast]];
//
//    }
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    adjustsScrollViewInsets_NO(self.tableView, self);
    
    // Do any additional setup after loading the view.
    
    //    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    //    [_timer setFireDate:[NSDate distantFuture]];
    self.defaultFailure = @"暂无数据";
    _btnUerBtnIndex = 1;
    
    _arrBtnUser = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"LaunchImageView"]) {
        LaunchView *launchV = [[LaunchView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        launchV.imageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"LaunchImageViewUrl"];
        
        [[APPDELEGATE window] addSubview:launchV];
        
    }
    
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showGuideVC"]) {
        GuideView *guideV = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        guideV.backgroundColor = [UIColor whiteColor];
        [[APPDELEGATE window] addSubview:guideV];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showGuideVC"];
        
        
        
    }
    
    
    
    NSData *dataFirstPageDataLocal = [[NSUserDefaults standardUserDefaults] dataForKey:@"firstPageDataLocal"];
    
    if (dataFirstPageDataLocal) {
        NSDictionary *dictFirstPageDataLocal = [NSKeyedUnarchiver unarchiveObjectWithData:dataFirstPageDataLocal];
        //    NSLog(@"%@",dictFirstPageDataLocal);
        
        
        if ([dictFirstPageDataLocal isKindOfClass:[NSDictionary class]]) {
            _arrFocus = [[NSMutableArray alloc] initWithArray:[FocusModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"focusNews"]]];
            if (![[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"hotMatches"] isKindOfClass:[NSNull class]]) {
                _arrInfolist = [[NSArray alloc] initWithArray:[FirstPInfoListModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"hotMatches"]]];
                //        NSLog(@"%@",[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"hotMatches"]);
            }
            
            _arrToHotzMost = [[NSArray alloc] initWithArray:[MostModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"most"]]];
            //大咖
            _arrUserListBigName = [[NSArray alloc] initWithArray:[UserlistModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"userlist"][@"bigNameList"]]];
            _arrUserListRedList = [[NSArray alloc] initWithArray:[UserlistModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"userlist"][@"redList"]]];
            _arrUserListWeekList = [[NSArray alloc] initWithArray:[UserlistModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"userlist"][@"weekList"]]];
            //红单数据
            _arrRedDan = [[NSArray alloc] initWithArray:[RedDanModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"redNews"]]];
            
            //    NSLog(@"%@",[[dictFirstPageDataLocal objectForKey:@"data"]objectForKey:@"hotMatches"]);
            _arrRollInfo = [[NSArray alloc] initWithArray:[RollInfoModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"rollInfo"]]];
            _arrNewslist = [NSArray arrayWithArray:[NewslistModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"newslist"]]];
            _hotRecommed = [NSArray arrayWithArray:[TuijiandatingModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"essenceRecommend"]]];
            
            
        }
    }
    
    
    //    NSLog(@"%@",[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"rollInfo"]);
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"oddstypeDetail"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"ver"];
    [self.view addSubview:self.tableView];
    //    [self.view addSubview:self.btnEuro];
    
    //推送跳转新闻页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToNewsWeb:) name:NotificationpushToNewsWeb object:nil];
    
    //  启动程序的时候收到推送信息
    NSData *launchOptionPushInfoData =[[NSUserDefaults standardUserDefaults] objectForKey:@"launchOptionPushInfo"];
    if (launchOptionPushInfoData) {
        NSDictionary *launchOptionPushInfo = [NSDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:launchOptionPushInfoData]];
        if (launchOptionPushInfo.allValues.count>0) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"launchOptionPushInfo"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationpushToNewsWeb object:nil userInfo:launchOptionPushInfo];
            
        }
        
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewContentOffsetZero) name:NotificationsetFirstTableViewContentOffsetZero object:nil];
    
    
    _viewBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
    _viewBar.backgroundColor = [UIColor blackColor];
    _viewBar.hidden = YES;
    [self.view addSubview:_viewBar];
    
    [self.tableView.mj_header beginRefreshing];
    
    [self.view addSubview:self.liveQuizImageView];

}

- (void)setTableViewContentOffsetZero
{
    if (_tableView.contentOffset.y != 0) {
        [self.tableView setContentOffset:CGPointZero animated:YES];
        
    }
}

#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[BasicTableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - 49)];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TuijianDatingCell class] forCellReuseIdentifier:cellFirstPageTuijian];
        [self.tableView registerNib:[UINib nibWithNibName:@"FirstFHuaTiCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellfirstHuati"];
        self.tableView.defaultPage = defaultPageFirst;
        self.tableView.defaultTitle = default_isLoading;
        
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.delegate =self;
        self.tableView.dataSource = self;
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        [self setTableHeader];
    }
    return _tableView;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
}

//返回单张图片
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_nodata) {
        return [UIImage imageNamed:@"nodataFirstP"];
        
    }
    return [UIImage imageNamed:@"clear"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    NSLog(@"imageAnimationForEmptyDataSet");
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
////返回标题文字
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = self.defaultFailure;
//    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
//- (nullable NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//
//    NSString *text = @"刷新后还是没有数据？\n一、检查您是否开启了网络权限\n\t1.打开【设置】\n\t2.重启手机\n二、检查本地网络状况\n\t请检查您的手机网络";
//    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (Width*375/750 - 20 < scrollView.contentOffset.y) {
        _viewBar.hidden = NO;
    }else{
        _viewBar.hidden = YES;
    }
}
- (void)setTableHeader
{
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    mjHeader.stateLabel.font = font13;
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    mjHeader.stateLabel.textColor = grayColor4;
    self.tableView.mj_header = mjHeader;
    
}
- (void)headerRefresh
{
    
    [self loadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (_nodata) {
        return 0;
    }
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_nodata) {
        return 0;
    }
    
    switch (section) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            if (_arrToHotzMost.count == 0) {
                return 0;
            }
            return 0;
        }
            break;
            
        case 2:
        {
            //这里为今日热点
            if (_arrInfolist.count == 0) {
                return 0;
            }
            return 1;
        }
            break;
        case 3:
        {
            if (_arrUserListBigName.count == 0 && _arrUserListRedList.count == 0 && _arrUserListWeekList.count == 0) {
                return 0;
            }
            return 1;
        }
            break;
            
        case 4:
        {
            if (_arrRedDan.count == 0) {
                return 0;
            }
            return 1;//红单播报
            
        }
            break;
        case 5:
        {
            //热门推荐
            if (_hotRecommed.count == 0) {
                return 0;
            }
            
            return _hotRecommed.count;
        }
            break;
        case 6:
        {
            if (_arrNewslist.count == 0) {
                return 0;
            }
            return _arrNewslist.count;
        }
            break;
        case 7:
        {
            return 0;
        }
            break;
            
        default:
            break;
            
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_nodata) {
        return 0;
    }
    
    switch (indexPath.section) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            if (_arrToHotzMost.count == 0) {
                return 0;
            }
            
            if (indexPath.row == 3) {
                return 110;
            } else {
                return 95;
            }
            
        }
            break;
        case 2:
        {
            
            if (_arrInfolist.count == 0) {
                return 0;
            }
            //            if (_arrInfolist.count == 1) {
            //               return 115 + 17;
            //            }
            
            return 190;
        }
            break;
        case 3:
        {
            //推荐名人
            if (_arrUserListBigName.count == 0 && _arrUserListRedList.count == 0 &&  _arrUserListWeekList.count == 0) {
                return 0;
            }
            switch (_btnUerBtnIndex) {
                case 1:{
                    if (_arrUserListBigName.count > 4) {
                        return 220;
                    }else{
                        if (_arrUserListBigName.count == 0) {
                            return 0;
                        }else{
                            return 120;
                        }
                        
                        
                    }
                    
                }
                case 2:{
                    if (_arrUserListRedList.count > 4) {
                        return 220;
                    }else{
                        if (_arrUserListRedList.count == 0) {
                            return 0;
                        }else{
                            return 120;
                        }
                        
                    }
                    
                }
                case 3:{
                    if (_arrUserListWeekList.count > 4) {
                        return 220;
                    }else{
                        if (_arrUserListWeekList.count == 0) {
                            return 0;
                        }else{
                            return 120;
                        }
                       
                    }
                    
                }
                    break;
                    
                default:
                    break;
            }
            return 220;
            
        }
            break;
            
        case 4:
        {
            if (_arrRedDan.count == 0) {
                return 0;
            }
            return 180;//红单播报
            
        }
        case 5:
        {
            //热门推荐
            if (_hotRecommed.count == 0) {
                return 0;
            }
            
            return 190;
            //            return [tableView fd_heightForCellWithIdentifier:@"first5" cacheByIndexPath:indexPath configuration:^(TuijianDatingCell *cell) {
            //                if (_hotRecommed.count>0) {
            //                    cell.type = typeTuijianCellFirstPage;
            //                    cell.model = _hotRecommed[indexPath.row];
            //                }
            //            }];
        }
            break;
        case 6:
        {
            if (_arrNewslist.count == 0) {
                return 0;
            }
            return 37;
        }
            break;
        case 7:
        {
            return 0;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}
- (firstHotInfoCycleView *)firstPg{
    if (!_firstPg) {
        _firstPg = [[firstHotInfoCycleView alloc] initWithFrame:CGRectMake(0, 0, Width,200)];
    }
    
    return _firstPg;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_nodata) {
        return [UITableViewCell new];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cell = @"first0";
            UITableViewCell *cellNull = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            return cellNull;
        }
            break;
            
        case 1:
        {
            
            if (_arrToHotzMost.count == 0) {
                return [UITableViewCell new];
                
            }
            
            if (indexPath.row == 0) {
                static NSString *cell = @"first1";
                TodayHotSpotsCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
                if (!cellNull) {
                    cellNull = [[TodayHotSpotsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
                }
                
                cellNull.selectedBackgroundView = [[UIView alloc] initWithFrame:cellNull.frame];
                cellNull.selectedBackgroundView.backgroundColor = colorF5;
                cellNull.row = indexPath.row;
                cellNull.model = _arrToHotzMost[indexPath.row];
                return cellNull;
            }else{
                static NSString *cell = @"firstTwo";
                TodayHotSpotsTwoCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
                if (!cellNull) {
                    cellNull = [[TodayHotSpotsTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
                }
                
                cellNull.selectedBackgroundView = [[UIView alloc] initWithFrame:cellNull.frame];
                cellNull.selectedBackgroundView.backgroundColor = colorF5;
                cellNull.row = indexPath.row;
                cellNull.model = _arrToHotzMost[indexPath.row];
                return cellNull;
            }
            
            
        }
            break;
            
        case 2:{
            //情报
            static NSString *cell = @"first2";
            UITableViewCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
            if (!cellNull) {
                cellNull = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            }
            cellNull.selectionStyle = UITableViewCellSelectionStyleNone;
            self.firstPg.arrData = _arrInfolist;
            self.firstPg.delegate = self;
            
            [cellNull.contentView addSubview:self.firstPg];
            return cellNull;
            
            
        }
            
            break;
        case 3://推荐名人
        {
            
            static NSString *cell = @"first3";
            UITableViewCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
            if (!cellNull) {
                cellNull = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            }
            [cellNull.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            
            cellNull.selectionStyle = UITableViewCellSelectionStyleNone;
            FirstPUserlistView *subVOne = [[FirstPUserlistView alloc] initWithFrame:CGRectMake(0, 0, Width, 220)];
            
            switch (_btnUerBtnIndex) {
                case 1:{
                    subVOne.arrData = _arrUserListBigName;
                    if (_arrUserListBigName.count > 4) {
                        subVOne.frame = CGRectMake(0, 0, Width, 220);
                    }else{
                        subVOne.frame = CGRectMake(0, 0, Width, 120);
                    }
                }
                    break;
                case 2:{
                    subVOne.arrData = _arrUserListRedList;
                    if (_arrUserListRedList.count > 4) {
                        subVOne.frame = CGRectMake(0, 0, Width, 220);
                    }else{
                        subVOne.frame = CGRectMake(0, 0, Width, 120);
                    }
                    
                }
                    break;
                case 3:{
                    subVOne.arrData = _arrUserListWeekList;
                    if (_arrUserListWeekList.count > 4) {
                        subVOne.frame = CGRectMake(0, 0, Width, 220);
                    }else{
                        subVOne.frame = CGRectMake(0, 0, Width, 120);
                    }
                    
                }
                    break;
                    
                default:
                    break;
            }
            subVOne.delegate = self;
            [cellNull.contentView addSubview:subVOne];
            
            
            return cellNull;
            
            
        }
            break;
            
        case 4://红单播报
        {
            
            if (_arrRedDan.count == 0) {
                return [UITableViewCell new];
                
            }
            
            static NSString *cell = @"first4";
            UITableViewCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
            if (!cellNull) {
                cellNull = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            }
            [cellNull.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            
            RedDanCycleView *redView = [[RedDanCycleView alloc] initWithFrame:CGRectMake(0, 0, Width, 180)];
            redView.arrData = _arrRedDan;
            //            cellNull.backgroundColor = redcolor;
            [cellNull.contentView addSubview:redView];
            return cellNull;//红单播报
            
        }
        case 5:
        {
            
            
            static NSString *cell = @"first5";
            
            TuijianDatingCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
            if (!cellNull) {
                cellNull = [[TuijianDatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            }
            cellNull.selectedBackgroundView = [[UIView alloc] initWithFrame:cellNull.frame];
            cellNull.selectedBackgroundView.backgroundColor = colorF5;
            cellNull.type =  typeTuijianCellFirstPage;
            cellNull.model = _hotRecommed[indexPath.row];
            return cellNull;
            
        }
            break;
        case 6:
        {
            
            return 0;
        }
            break;
        case 7:
        {
            return 0;
        }
            break;
            
        default:
            break;
    }
    return nil;
}
- (void)dicSelectedToFenxiWithModel:(FirstPInfoListModel *)model
{
    
    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)model.mid] toPageindex:2 toItemIndex:0];
    
}
- (void)selectedUserWithId:(UserlistModel *)user
{
    //    NSLog(@"Idid--------%ld",Idid);
    
    
    if (user.userid == 1) {
        return;
    }
    
    UserViewController *userVC = [[UserViewController alloc] init];
    userVC.userId = user.userid;
    userVC.userName = user.nickname;
    userVC.userPic = user.pic;
    userVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (_nodata) {
        return nil;
    }
    
    
    switch (section) {
        case 0:
        {
            UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width,Width*375/750 + 0)];
            viewHeader.backgroundColor = colorTableViewBackgroundColor;
            
            
            _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width, Width*375/750) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
            _cycleView.currentPageDotColor = redcolor;
            _cycleView.pageDotColor = [UIColor whiteColor];
            
            _cycleView.autoScrollTimeInterval = 5;
            _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            _cycleView.titleLabelHeight = 28;
            _cycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
            NSMutableArray *arrpics = [NSMutableArray array];
            NSMutableArray *arrtitles = [NSMutableArray array];
            
            for (int i = 0; i<_arrFocus.count; i++) {
                FocusModel *model = [_arrFocus objectAtIndex:i];
                if (model.pic == nil) {
                    model.pic = @"";
                }
                if (model.title == nil) {
                    model.title = @"";
                }
                if (model.url2 == nil) {
                    model.url2 = @"";
                }
                [arrtitles addObject:model.title];
                [arrpics addObject:model.pic];
            }
            
            _cycleView.titlesGroup = arrtitles;
            
            //            NSArray *arrimg = [NSArray arrayWithObjects:[UIImage imageNamed:@"fff1.jpg"],[UIImage imageNamed:@"fff2.jpg"], nil];
            //
            //            _cycleView.localizationImageNamesGroup = arrimg;
            _cycleView.imageURLStringsGroup = arrpics;
            
            
            //轮播图
            [viewHeader addSubview:_cycleView];
            
            
            //            滚动情报
            UIView *viewHeaderTwo = [[UIView alloc] initWithFrame:CGRectMake(0, _cycleView.bottom, Width,39+5)];
            viewHeaderTwo.backgroundColor = [UIColor whiteColor];
            
            UIImageView *img= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gunqiuQB"]];
            //            img.frame = CGRectMake(15, 15, 63, 14);
            img.center = CGPointMake(img.center.x + 10, 22);
            [viewHeaderTwo addSubview:img];
            
            UIView *viewShu = [[UIView alloc] initWithFrame:CGRectMake(img.right - 5, 0, 1, 25)];
            viewShu.center = CGPointMake(viewShu.center.x + 15, 22);
            viewShu.backgroundColor = colorTableViewBackgroundColor;
            [viewHeaderTwo addSubview:viewShu];
            
            
            if (_arrRollInfo.count >0) {
                
                NSMutableArray *arrTitle = [NSMutableArray array];
                for (int i = 0; i<_arrRollInfo.count; i++) {
                    RollInfoModel *roll =  [_arrRollInfo objectAtIndex:i];
                    if (roll.on_index_title == nil || [roll.on_index_title isEqualToString:@""]) {
                        roll.on_index_title = @"";
                    }
                    [arrTitle addObject:roll.on_index_title];
                }
                
                VierticalScrollView *scroView = [VierticalScrollView initWithTitleArray:arrTitle AndFrame:CGRectMake(viewShu.right + 10, 0, Width - viewShu.right - 15, 44)];
                scroView.delegate =self;
                
                [viewHeaderTwo addSubview:scroView];
                
            }
            //            [viewHeader addSubview:viewHeaderTwo];
            
            return viewHeader;
            
        }
            break;
            
        case 1:
        {
            UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width,100)];
            viewHeader.backgroundColor = [UIColor whiteColor];
            //四个按钮
            [viewHeader addSubview:self.viewInfo];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5 , Width, 0.5)];
            line.backgroundColor = colorDD;
            [viewHeader addSubview:line];
            
            return viewHeader;
        }
            break;
        case 2:{
            return [UIView new];
        }
            break;
        case 3:
        {
            if (_arrUserListBigName.count == 0 && _arrUserListWeekList.count == 0 && _arrUserListRedList.count == 0) {
                return [UIView new];
            }
            
            UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width,39+5)];
            viewHeader.backgroundColor = [UIColor whiteColor];
            UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
            labTitle.text = @"推荐名人";
            labTitle.textColor = color33;
            labTitle.font = BoldFont6(fontSize14);
            labTitle.backgroundColor = [UIColor whiteColor];
            labTitle.textAlignment = NSTextAlignmentLeft;
            [viewHeader addSubview:labTitle];
            
            
            UIButton *btnWin = [UIButton buttonWithType:UIButtonTypeCustom];
            //            btnWin.frame = CGRectMake(Width - 10 - 50, 0, 50, 44);
            btnWin.titleLabel.font = font14;
            //            [btnWin setTitle:@" 胜率 " forState:UIControlStateNormal];
            [btnWin setTitle:@"" forState:UIControlStateNormal];
            
            [btnWin setTitleColor:color66 forState:UIControlStateNormal];
            [btnWin setTitleColor:color33 forState:UIControlStateSelected];
            btnWin.tag = 3;
            
            [btnWin addTarget:self action:@selector(btnUserBtn:) forControlEvents:UIControlEventTouchUpInside];
            [viewHeader addSubview:btnWin];
            [_arrBtnUser addObject:btnWin];
            [btnWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(viewHeader.mas_top);
                make.bottom.mas_equalTo(viewHeader.mas_bottom);
                make.right.mas_equalTo(viewHeader.mas_right).offset(-0);
                make.width.mas_equalTo(0);
            }];
            
            
            UIView *lineOne = [[UIView alloc] init];
            //            lineOne.backgroundColor = colorDD;
            [viewHeader addSubview:lineOne];
            [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(btnWin.mas_left).offset(-0);
                make.centerY.mas_equalTo(viewHeader.mas_centerY);
                make.height.mas_offset(20);
                make.width.mas_offset(0.5);
            }];
            
            UIButton *btnRed = [UIButton buttonWithType:UIButtonTypeCustom];
            btnRed.titleLabel.font = font14;
            [btnRed setTitle:@" 连红 " forState:UIControlStateNormal];
            [btnRed setTitleColor:color66 forState:UIControlStateNormal];
            [btnRed setTitleColor:color33 forState:UIControlStateSelected];
            btnRed.tag = 2;
            [btnRed addTarget:self action:@selector(btnUserBtn:) forControlEvents:UIControlEventTouchUpInside];
            [viewHeader addSubview:btnRed];
            [_arrBtnUser addObject:btnRed];
            [btnRed mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(viewHeader.mas_top);
                make.bottom.mas_equalTo(viewHeader.mas_bottom);
                make.right.mas_equalTo(lineOne.mas_left).offset(-10);
            }];
            
            UIView *lineTwo = [[UIView alloc] init];
            lineTwo.backgroundColor = colorDD;
            [viewHeader addSubview:lineTwo];
            [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(btnRed.mas_left).offset(-10);
                make.centerY.mas_equalTo(viewHeader.mas_centerY);
                make.height.mas_offset(20);
                make.width.mas_offset(0.5);
            }];
            
            
            UIButton *btnBig = [UIButton buttonWithType:UIButtonTypeCustom];
            btnBig.titleLabel.font = font14;
            [btnBig setTitle:@" 大咖 " forState:UIControlStateNormal];
            [btnBig setTitleColor:color66 forState:UIControlStateNormal];
            [btnBig setTitleColor:color33 forState:UIControlStateSelected];
            btnBig.tag = 1;
            [btnBig addTarget:self action:@selector(btnUserBtn:) forControlEvents:UIControlEventTouchUpInside];
            [viewHeader addSubview:btnBig];
            [_arrBtnUser addObject:btnBig];
            [btnBig mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(viewHeader.mas_top);
                make.bottom.mas_equalTo(viewHeader.mas_bottom);
                make.right.mas_equalTo(lineTwo.mas_left).offset(-10);
            }];
            
            btnBig.userInteractionEnabled = YES;
            btnRed.userInteractionEnabled = YES;
            btnWin.userInteractionEnabled = YES;
            switch (_btnUerBtnIndex) {
                case 1:{
                    btnBig.titleLabel.font = BoldFont4(fontSize14);
                    btnBig.selected = YES;
                }
                    
                    break;
                case 2:{
                    btnRed.titleLabel.font = BoldFont4(fontSize14);
                    btnRed.selected = YES;
                }
                    
                    break;
                case 3:{
                    btnWin.titleLabel.font = BoldFont4(fontSize14);
                    btnWin.selected = YES;
                }
                    
                    break;
                    
                default:
                    break;
            }
            
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, labTitle.bottom, Width, 0.5)];
            line.backgroundColor = colorDD;
            [viewHeader addSubview:line];
            
            return viewHeader;
            
        }
            break;
        case 4:
        {
            
            return [UIView new];//红单播报
            
        }
        case 5:
        {
            if (_hotRecommed.count == 0) {
                return [UIView new];
            }
            
            UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width,39+5)];
            UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
            labTitle.text = @"    热门推荐";
            labTitle.textColor = color33;
            labTitle.font = BoldFont6(fontSize14);
            labTitle.backgroundColor = [UIColor whiteColor];
            labTitle.textAlignment = NSTextAlignmentLeft;
            [viewHeader addSubview:labTitle];
            UIButton *btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
            btnMore.frame = CGRectMake(Width - 15 - 50, 5, 45, 39);
            [btnMore setTitle:@"更多" forState:UIControlStateNormal];
            [btnMore setTitleColor:color99 forState:UIControlStateNormal];
            [btnMore.titleLabel setFont:font13];
            
            btnMore.tag = section;
            [btnMore addTarget:self action:@selector(toMore:) forControlEvents:UIControlEventTouchUpInside];
            [viewHeader addSubview:btnMore];
            
            UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(45, 0, 7, 14)];
            imageMore.center = CGPointMake(imageMore.center.x, btnMore.height/2);
            imageMore.image = [UIImage imageNamed:@"meRight"];
            [btnMore addSubview:imageMore];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, labTitle.bottom, Width, 0.5)];
            line.backgroundColor = colorDD;
            [viewHeader addSubview:line];
            return viewHeader;
            
        }
            break;
        case 6:
        {
            
            
            return 0;
            
        }
            break;
        case 7:
        {
            return 0;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    if (_nodata) {
        return nil;
    }
    
    
    if (section == 5 && _hotRecommed.count > 0) {
        UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
        bkView.backgroundColor = colorF5;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"查看更多推荐" forState:UIControlStateNormal];
        [btn setTitleColor:color33 forState:UIControlStateNormal];
        btn.titleLabel.font = font14;
        btn.tag = 5;
        [bkView addSubview:btn];
        [btn addTarget:self action:@selector(toMore:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bkView.mas_centerY).offset(-3);
            make.centerX.mas_equalTo(bkView.mas_centerX);
            
        }];
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"moreBtn"];
        [bkView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(btn.mas_centerY);
            make.left.mas_equalTo(btn.mas_right).offset(0);
            make.width.mas_offset(16);
            make.height.mas_offset(16);
        }];
        
        
        return bkView;
    }
    
    return [UIView new];
    
}
- (void)btnUserBtn:(UIButton *)btn{
    
    for (int i = 0; i < _arrBtnUser.count; i ++) {
        UIButton *selebtn = _arrBtnUser[i];
        if (btn.tag == selebtn.tag ) {
            selebtn.selected = YES;
            _btnUerBtnIndex = selebtn.tag;
            selebtn.titleLabel.font = BoldFont4(fontSize14);
            
        }else{
            selebtn.titleLabel.font = font14;
            selebtn.selected = NO;
        }
        
    }
    
    
    [self.tableView reloadData];
    
}
- (void)toMore:(UIButton *)btn
{
    if (btn.tag ==4) {
        //        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"qingbaoFirstPage"];
        //
        //      UINavigationController *nav2 = [APPDELEGATE.customTabbar.viewControllers objectAtIndex:2];
        //        [nav2 popToRootViewControllerAnimated:YES];
        //        [APPDELEGATE.customTabbar setSelectedIndex:2];
        
    }else if (btn.tag == 2){
        
        //        NewRecommandVC *recmdLVC = [[NewRecommandVC alloc] init];
        //        recmdLVC.hidesBottomBarWhenPushed = YES;
        //        recmdLVC.titleStr = @"专家榜";
        //        recmdLVC.typeList = typeListOne;
        //
        //        [APPDELEGATE.customTabbar pushToViewController:recmdLVC animated:YES];
    }else if (btn.tag == 5){
        UINavigationController *nav2 = [APPDELEGATE.customTabbar.viewControllers objectAtIndex:3];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tuijianSetSize" object:nil];
        
        [nav2 popToRootViewControllerAnimated:YES];
        [APPDELEGATE.customTabbar setSelectedIndex:3];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_nodata) {
        return 0;
    }
    
    
    switch (section) {
        case 0:
            
            return Width*375/750 + 0;
            
            break;
        case 1:
            return 100;
            
            break;
        case 2:
            return 0.0001;
            
            break;
        case 3:
            if (_arrUserListWeekList.count == 0 && _arrUserListWeekList.count == 0 && _arrUserListBigName.count == 0) {
                return 0.0001;
            }
            
            return 44;
            
            break;
        case 4:
        {
            
            return 0.0001;//红单播报
            
        }
        case 5:
        {
            if (_hotRecommed.count == 0) {
                return 0.0001;
            }
            return 39+5;
        }
            break;
        case 6:
        {
            return 39+5;
        }
            break;
        case 7:
        {
            return 0.00001;
        }
            break;
            
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (_nodata) {
        return 0;
    }
    
    switch (section) {
        case 0:
            return 0.00001;
            break;
        case 1:
            
            
            return 10;
            break;
        case 2://情报
            if (_arrInfolist.count > 0) {
                return 10;
            }
            
            break;
        case 3:{
            if (_arrUserListWeekList.count > 0 || _arrUserListRedList.count > 0 || _arrUserListBigName.count > 0) {
                return 10;
            }
            
        }
            break;
        case 4:{
            if (_arrRedDan.count> 0) {
                return 10;
            }
        }
            
            break;
            
        case 5:
            if (_hotRecommed.count > 0) {
                return 44;
            }
            
            break;
        default:
            break;
    }
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 5) {
        
        TuijianDetailVC *infoVC = [[TuijianDetailVC alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        TuijiandatingModel *model = _hotRecommed[indexPath.row];
        infoVC.modelId = model.idId;
        [APPDELEGATE.customTabbar pushToViewController:infoVC animated:YES];
    }else if(indexPath.section == 6)
    {
    }else if(indexPath.section == 1){
        
        switch (indexPath.row) {
            case 0:{
                MostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:0 toItemIndex:0];
                
                
            }
                break;
            case 1:{
                MostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:1 toItemIndex:4];
                
            }
            case 2:{
                MostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:1 toItemIndex:4];
            }
            case 3:{
                MostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:0 toItemIndex:0];
            }
                
            default:{
                MostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:0 toItemIndex:0];
            }
                break;
        }
        
        
    }
    
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    FocusModel *fmodel = [_arrFocus objectAtIndex:index];
    switch (fmodel.linkType) {
        case 0:
        {
            //不跳转
        }
            break;
        case 1:
        {
            //            网页
            
            //跳转网页
            WebDetailViewController *webDetailVC = [[WebDetailViewController alloc] init];
            webDetailVC.urlTitle = fmodel.title;
            webDetailVC.url = fmodel.url2;
            webDetailVC.urlId = [NSString stringWithFormat:@"%ld",fmodel.idId];
            webDetailVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            
        }
            break;
        case 2:
        {
            //            比赛详情
            //        linktap: 0：分析  1：指数 2：情报  3：推荐  4：直播
            [self toFenxiWithMatchId:fmodel.url2 toPageindex:fmodel.tabType toItemIndex:0];
            
            
        }
            break;
        case 3:
        {
            //          更新版本
            
            
        }
            break;
        case 4:
        {
            //            推荐详情
            TuijianDetailVC *tuijianDT = [[TuijianDetailVC alloc] init];
            tuijianDT.modelId =[fmodel.url2 integerValue];
            tuijianDT.typeTuijianDetailHeader = typeTuijianDetailHeaderCellDanchang;
            tuijianDT.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:tuijianDT animated:YES];
            
        }
            break;
        case 5:
        {
            //            分析师主页
            UserViewController *userVC = [[UserViewController alloc] init];
            userVC.userId = [fmodel.url2 integerValue];
            userVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
            
        }
            break;
        case 6:
        {
            //            分析师主页
            LoadHtmlStringVC *htmlVC = [[LoadHtmlStringVC alloc] init];
            htmlVC.urlTitle = fmodel.title;
            htmlVC.urlContent = fmodel.content;
            htmlVC.urlId = [NSString stringWithFormat:@"%ld",fmodel.idId];
            htmlVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:htmlVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
}

-(void)clickTitleButton:(UIButton *)button
{
    RollInfoModel *roll = [_arrRollInfo objectAtIndex:button.tag -1];
    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)roll.match_id] toPageindex:2 toItemIndex:0];
    
}

- (DataModelView *)viewInfo
{
    if (!_viewInfo) {
        _viewInfo = [[DataModelView alloc] initWithFrame:CGRectMake(0, 0, Width, 100)];
        _viewInfo.backgroundColor= [UIColor whiteColor];
        _viewInfo.delegate = self;
    }
    return _viewInfo;
}
- (void)didSelectedDataModelViewIndex:(NSInteger)index;
{
    switch (index) {
        case 4:
        {//交易冷热
            JiaoYiViewController * jiaoyi = [[JiaoYiViewController alloc] init];
            jiaoyi.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:jiaoyi animated:YES];
            
            
            
            
        }
            break;
        case 5:
        {//投注异常
            BettingVC *odd = [[BettingVC alloc] init];
            odd.hidesBottomBarWhenPushed = YES;
            
            [APPDELEGATE.customTabbar pushToViewController:odd animated:YES];
            
            
            
            
            
            
        }
            break;
        case 7:
        {//盘王指数
            PanwangZhishuVC *record = [[PanwangZhishuVC alloc] init];
            record.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:record animated:YES];
        }
            break;
        case 6:
        {//极限拐点
            JiXianVC *jixian = [[JiXianVC alloc] init];
            jixian.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:jixian animated:YES];
        }
            break;
        case 1:
        {
//            BaolengZhishuVC * jiaoyi = [[BaolengZhishuVC alloc] init];
//            jiaoyi.hidesBottomBarWhenPushed = YES;
//            [APPDELEGATE.customTabbar pushToViewController:jiaoyi animated:YES];
            
            LiveViewController *control = [[LiveViewController alloc]init];
            [self.navigationController pushViewController:control animated:YES];
            
        }
            break;
        case 0:
        {//极限拐点
            [self.tabBarController setSelectedIndex:1];
            
//            TongpeiTongjiVC *odd = [[TongpeiTongjiVC alloc] init];
//            odd.hidesBottomBarWhenPushed = YES;
//
//            [APPDELEGATE.customTabbar pushToViewController:odd animated:YES];
        }
            break;
        case 2:
        {//极限拐点
//            PeilvYichangVC *odd = [[PeilvYichangVC alloc] init];
//            odd.hidesBottomBarWhenPushed = YES;
//
//            [APPDELEGATE.customTabbar pushToViewController:odd animated:YES];
            ModelPredictionViewController *control = [[ModelPredictionViewController alloc]init];
            [self.navigationController pushViewController:control animated:YES];
        }
            break;
        case 3:
        {//极限拐点
            
            ToolKitViewController *control = [[ToolKitViewController alloc]init];
            [self.navigationController pushViewController:control animated:YES];
//            YapanZhoushouVC *odd = [[YapanZhoushouVC alloc] init];
//            odd.hidesBottomBarWhenPushed = YES;
//
//            [APPDELEGATE.customTabbar pushToViewController:odd animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadData
{
    _nodata = NO;
    self.tableView.backgroundColor = colorTableViewBackgroundColor;
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter] ];
    //    NSString *ver =[[NSUserDefaults standardUserDefaults] objectForKey:@"ver"];
    [parameter setObject:@"0" forKey:@"ver"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_firstIndex] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        [self.tableView.mj_header endRefreshing];
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            //            NSLog(@"%@",responseOrignal);
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseOrignal];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"firstPageDataLocal"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            // 焦点图
            _arrFocus = [[NSMutableArray alloc] initWithArray:[FocusModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"focusNews"]]];
            if (![[[responseOrignal objectForKey:@"data"] objectForKey:@"hotMatches"] isKindOfClass:[NSNull class]]) {
                //                    情报
                NSArray *arrinfo = [[NSArray alloc] initWithArray:[FirstPInfoListModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"hotMatches"]]];
                
                
                for (int i = 0; i<arrinfo.count; i++) {
                    //为了即时比分数据准确
                    FirstPInfoListModel *model = [arrinfo objectAtIndex:i];
                    for (int j = 0; j<_arrInfolist.count; j++) {
                        FirstPInfoListModel *mModel = [_arrInfolist objectAtIndex:j];
                        if (mModel.mid == model.mid) {
                            
                            if (model.homescore<mModel.homescore) {
                                model.homescore = mModel.homescore;
                                
                            }
                            if (model.guestscore < mModel.guestscore) {
                                model.guestscore = mModel.guestscore;
                                
                            }
                        }
                        
                        
                    }
                    
                    
                }
                
                _arrInfolist = [NSArray arrayWithArray:arrinfo];
            }
            
            
            if (_arrInfolist.count>0) {
                //                [self performSelector:@selector(startTime) withObject:nil afterDelay:5];
            }
            
            
            //            专家
            _arrUserListBigName = [[NSArray alloc] initWithArray:[UserlistModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"userlist"][@"bigNameList"]]];
            _arrUserListRedList = [[NSArray alloc] initWithArray:[UserlistModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"userlist"][@"redList"]]];
            _arrUserListWeekList = [[NSArray alloc] initWithArray:[UserlistModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"userlist"][@"weekList"]]];
            //            滚动情报
            _arrRollInfo = [[NSArray alloc] initWithArray:[RollInfoModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"rollInfo"]]];
            //红单数据
            _arrRedDan = [[NSArray alloc] initWithArray:[RedDanModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"redNews"]]];
            
            _arrNewslist = [NSArray arrayWithArray:[NewslistModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"newslist"]]];
            _arrToHotzMost = [[NSArray alloc] initWithArray:[MostModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"most"]]];
            //            推荐
            _hotRecommed = [NSArray arrayWithArray:[TuijiandatingModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"essenceRecommend"]]];
            
            NSString *str =[NSString stringWithFormat:@"%ld",[[[responseOrignal objectForKey:@"data"] objectForKey:@"ver"] longValue]];
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"ver"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            self.tableView.defaultPage = defaultPageFirst;
            self.tableView.defaultTitle = default_noMatch;
            
            [self.tableView reloadData];
            
        }else{
            self.tableView.defaultPage = defaultPageForth;
            self.tableView.defaultTitle = default_loadFailure;
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstPageDataLocal"]) {
                
                _nodata = YES;
                
                self.tableView.backgroundColor = [UIColor whiteColor];
                
                
                [self.tableView reloadData];
                
            }
            
            //            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.tableView.defaultPage = defaultPageForth;
        self.tableView.defaultTitle = default_loadFailure;
        self.defaultFailure =errorDict;
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstPageDataLocal"]) {
            
            _nodata = YES;
            
            self.tableView.backgroundColor = [UIColor whiteColor];
            
            
            [self.tableView reloadData];
            
        }
        
        
        
    }];
}


//loop 跳转分析页
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    //index 1 基本面 2 情报面 3 推荐
    
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
        [parameter setObject:@"3" forKey:@"flag"];
        [parameter setObject:idID forKey:@"sid"];
        [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                
                LiveScoreModel *model = [LiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                //从首页跳转分析页的时候不用反转
                model.neutrality = NO;
                FenxiPageVC *fenxiVC = [[FenxiPageVC alloc] init];
                fenxiVC.model = model;
                
                fenxiVC.segIndex = itemIndex;
                fenxiVC.currentIndex = pageIndex;
                
                fenxiVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
                
            }
            _isToFenxi = NO;
            
            
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _isToFenxi = NO;
            
        }];
        
        
        
    }else{
        
        
    }
    
    
}
//通知跳转页面
- (void)pushToNewsWeb:(NSNotification *)nofication
{
    
    
    NSDictionary *pushInfo = nofication.userInfo;
    
    if ([pushInfo objectForKey:@"catalog"]== nil) {
        
    }else{
        NSInteger eventID = [[pushInfo objectForKey:@"catalog"]integerValue];
        switch (eventID) {
            case 0://首页
            {
                
            }
                break;
            case 2://推荐
            {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:3 toItemIndex:0];
            }
                
                break;
            case 1://情报
            {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:2 toItemIndex:0];
            }
                break;
            case 3://新闻呢
                //跳转网页
            {
                WebDetailViewController *webDetailVC = [[WebDetailViewController alloc] init];
                webDetailVC.urlTitle = [pushInfo objectForKey:@"title"];
                webDetailVC.url = [pushInfo objectForKey:@"url"];
                webDetailVC.urlId = [pushInfo objectForKey:@"targetid"];
                webDetailVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            }
                
                break;
            case 4://直播
            {
                [ self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:4 toItemIndex:0];
            }
                
                break;
            case 5://推荐详情
            {
                TuijianDetailVC *tuijianDT = [[TuijianDetailVC alloc] init];
                tuijianDT.modelId =[[pushInfo objectForKey:@"targetid"] integerValue];
                tuijianDT.typeTuijianDetailHeader = typeTuijianDetailHeaderCellDanchang;
                tuijianDT.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:tuijianDT animated:YES];
            }
                
                break;
            case 6://推荐详情 串关
            {
                TuijianDetailVC *tuijianDT = [[TuijianDetailVC alloc] init];
                tuijianDT.modelId =[[pushInfo objectForKey:@"targetid"] integerValue];
                tuijianDT.typeTuijianDetailHeader = typeTuijianDetailHeaderCellChuanGuan;
                tuijianDT.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:tuijianDT animated:YES];
            }
                
                break;
            case 7://推荐详情 足彩
            {
                TuijianDetailVC *tuijianDT = [[TuijianDetailVC alloc] init];
                tuijianDT.modelId =[[pushInfo objectForKey:@"targetid"] integerValue];
                tuijianDT.typeTuijianDetailHeader = typeTuijianDetailHeaderCellZucai;
                tuijianDT.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:tuijianDT animated:YES];
            }
                
                break;
                
            default:
                break;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    //    if (indexPath.section == 2) {
    //        return;
    //    }
    _seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    _seleCell.backgroundColor = colorF5;
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _seleCell.backgroundColor = [UIColor whiteColor];
    
}


- (UIView *)getParentViewOfTitleAndMessageFromView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            return view;
        }else{
            UIView *resultV = [self getParentViewOfTitleAndMessageFromView:subView];
            if (resultV) return resultV;
        }
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------- 直播答题

#pragma mark - Private Method

/**
 
 *  处理拖动手势
 
 *
 
 *  @param recognizer 拖动手势识别器对象实例
 
 */

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    //视图前置操作
    
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:self.view];
    
    CGFloat centerY = center.y + translation.y;
    CGFloat centerX = center.x + translation.x;
    // 下边界
    if (centerY > self.view.height - self.navigationController.tabBarController.tabBar.height -  recognizer.view.frame.size.width / 2) {
        centerY = self.view.height - self.navigationController.tabBarController.tabBar.height -  recognizer.view.frame.size.width / 2;
    }
    // 上边界
    if (centerY < cornerRadius) {
        centerY = cornerRadius;
    }
    // 左边界
    if (centerX < cornerRadius) {
        centerX = cornerRadius;
    }
    // 右边界
    if (centerX > Width  - cornerRadius) {
        centerX = Width  - cornerRadius;
    }
    
    recognizer.view.center = CGPointMake(centerX, centerY);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {

        //计算速度向量的长度，当他小于200时，滑行会很短

//        CGPoint velocity = [recognizer velocityInView:self.view];
//        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
//        CGFloat slideMult = magnitude / 200;

        //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult); //e.g. 397.973175, slideMult: 1.989866

        //基于速度和速度因素计算一个终点

//        float slideFactor = 0.1 * slideMult;

//        CGPoint finalPoint = CGPointMake(center.x + (velocity.x * slideFactor),
//
//                                         center.y + (velocity.y * slideFactor));

        //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限

//        finalPoint.x = MIN(MAX(finalPoint.x, cornerRadius), self.view.bounds.size.width - cornerRadius - 5);
//        finalPoint.y = MIN(MAX(finalPoint.y, cornerRadius), self.view.bounds.size.height - cornerRadius - self.navigationController.tabBarController.tabBar.height);

        //使用 UIView 动画使 view 滑行到终点
        
        if (centerX > recognizer.view.superview.width / 2) {
            centerX = recognizer.view.superview.width - cornerRadius - 5;
        } else {
            centerX = cornerRadius + 5;
        }
        
        CGPoint centerPoint = CGPointMake(centerX, centerY);
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            recognizer.view.center = centerPoint;
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)loadLiveData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveQuiz] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        NSString *code = responseOrignal[@"code"];
        if ([code isEqualToString:@"200"]) {
            NSDictionary *dic = responseOrignal[@"data"];
            NSString *icon = dic[@"icon"];
            self.href = dic[@"href"];
            if (icon) {
                [self.liveQuizImageView sd_setImageWithURL:[NSURL URLWithString:icon]];
                self.liveQuizImageView.hidden = false;
            } else {
                self.liveQuizImageView.hidden = YES;
            }
            
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        NSLog(@"32323");
    }];
}

#pragma mark - Events

- (void)liveQuziAction:(UITapGestureRecognizer *)tap {
    WebModel *model = [[WebModel alloc]init];
    model.title = @"直播答题";
    model.webUrl = self.href;
    model.hideNavigationBar = YES;
    LiveQuizViewController *controller = [[LiveQuizViewController alloc]init];
    controller.model = model;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Lazy Load

- (UIImageView *)liveQuizImageView {
    if (_liveQuizImageView == nil) {
        _liveQuizImageView = [UIImageView new];
        _liveQuizImageView.frame = CGRectMake(Width - 55, 2 * (Height / 3), 50, 50);
        _liveQuizImageView.contentMode = UIViewContentModeScaleAspectFill;
        _liveQuizImageView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liveQuziAction:)];
        [_liveQuizImageView addGestureRecognizer:tap];
        _liveQuizImageView.userInteractionEnabled = YES;
        _liveQuizImageView.hidden = YES;
        UIPanGestureRecognizer *panTouch = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [_liveQuizImageView addGestureRecognizer:panTouch];
    }
    return _liveQuizImageView;
}

@end
