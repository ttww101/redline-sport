//
//  FenxiPageVC.m
//  GQapp
//
//  Created by WQ on 2017/1/13.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#import "DCScrollVIew.h"
#import "FenxiHeaderView.h"
#import "PictureModel.h"
#import "FenxiPageVC.h"
#import "BifenDTTable.h"

#import "NewQingbaoTableView.h"
#import "InfoListModel.h"
#import "TuijianDatingTableView.h"
//#import "TitlePagerView.h"
#import "TitleIndexView.h"
#import "LivingModel.h"
#import "TimeModel.h"

#import "NewTuijianHtml.h"
//#import "NewZhiBoWebView.h"
#import "ZhiboTableView.h"
#import "JiBenWebView.h"
#import "RelRecNewVC.h"
#import "ToAnalystsVC.h"
#import "FenXiHeaderBottomView.h"
#import "SRWebSocket.h"
#import "RecommendedWebView.h"
#import "ArchiveFile.h"
#import "ToolWebViewController.h"
#import "AnalysisWebview.h"
#import "ShowActivityView.h"
#import "RecommendedWKWeb.h"

@interface FenxiPageVC ()<UIScrollViewDelegate,NewQingbaoTableViewDelegate,TuijianDatingTableViewDelegate,ViewPagerDelegate,TitleIndexViewDelegate,FenxiHeaderViewDelegate,UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate,SRWebSocketDelegate>



@property (nonatomic, strong) BifenDTTable *tableView;
@property (nonatomic, strong) TitleIndexView *titleView;
@property (nonatomic, strong) DCScrollVIew *scrollMainView;
@property (nonatomic, strong) NSMutableArray *arrTableViews;
@property (nonatomic, strong) FenXiHeaderBottomView        *hederBottomView;
@property (nonatomic, assign) BOOL hideHeaderView;

@property (nonatomic, strong) FenxiHeaderView *headerView;


@property (nonatomic, strong) NewQingbaoTableView *NewQBTableView;
@property (nonatomic, strong) TuijianDatingTableView *tuiJianTable;
@property (nonatomic, strong) JiBenWebView *webView;
@property (nonatomic, strong) NewTuijianHtml *webViewZhiShu;//指数
@property (nonatomic, strong) RecommendedWKWeb *recommendWeb;
@property (nonatomic , strong) AnalysisWebview *analysisWeb; // 分析


@property (nonatomic, strong) ZhiboTableView *webZhiBo;//直播的页面
//@property (nonatomic, strong) NewZhiBoWebView *webZhiBo;//直播的页面


@property (nonatomic, assign) NSInteger typeNum;
//当前第几个页面
@property (nonatomic, assign) CGFloat   temHeight;

//发布的三个按钮
@property (nonatomic, strong) UIButton *btnFabu;
@property (nonatomic, strong) UIButton *btnFabuJingcai;
@property (nonatomic, strong) UIButton *btnFabuTuijian;

@property (nonatomic, assign) NSInteger isShareQB;
//底层的tableview 可不可以滑动；
@property (nonatomic, assign)BOOL mainTableCanscroll;
@property (nonatomic, strong) NavView *nav;
//导航栏上的team
@property (nonatomic, strong) UIView *viewT;
@property (nonatomic, strong) UILabel *labVS;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong)SRWebSocket *webSocket;

@property (nonatomic , strong) UIImageView *liveQuizImageView;
@property (nonatomic , copy) NSDictionary *activityDic;

@property (nonatomic, assign) BOOL isBack;

@property (nonatomic , strong) ShowActivityView *animationActivityView;

@end

@implementation FenxiPageVC

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}

- (void)dealloc
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainTableCanscroll = YES;
    
    [[UINavigationBar appearance]setTranslucent:NO];
    [[UITabBar appearance]setTranslucent:NO];
    
    if (!self.currentIndex) {
        self.currentIndex = 0;
    }
    self.view .backgroundColor = [UIColor whiteColor];
    _isShareQB = 0;
    
    _typeNum = 1;
    [self.scrollMainView setContentOffset:CGPointMake(self.currentIndex * Width,0) animated:NO];
    [self.titleView updateSelectedIndex:self.currentIndex];
    //    self.delegate = self;
    self.headerView.imageRight.hidden = YES;
    _nav.btnRight.hidden = YES;
    [self.view addSubview:self.tableView];
    [self setNavView];
    [self lodaDataAnalysisQB];
    [self lodaDataTiDian];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHeaderData:) name:@"NSNotificationupdateHeaderData" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewFrame) name:@"changeTableViewFrame" object:nil];
    
    
    if (self.model.matchstate ==0) {
        
        //        UIImage *imageFabu = [UIImage imageNamed:@"fabuJingcai"];
        
        //        _btnFabuJingcai = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _btnFabuJingcai.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 30, 30);
        //        [_btnFabuJingcai setBackgroundImage:[UIImage imageNamed:@"fabuJingcai"] forState:UIControlStateNormal];
        //        [_btnFabuJingcai setBackgroundImage:[UIImage imageNamed:@"fabuJingcai"] forState:UIControlStateHighlighted];
        //
        //        [_btnFabuJingcai addTarget:self action:@selector(btnFabuCilick:) forControlEvents:UIControlEventTouchUpInside];
        //        //        _btnFabu.hidden = YES;
        //        _btnFabuJingcai.tag = 3;
        //        _btnFabuJingcai.hidden=YES;
        //
        //        [self.view addSubview:_btnFabuJingcai];
        
        
        
        _btnFabuTuijian = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
        [_btnFabuTuijian setBackgroundImage:[UIImage imageNamed:@"fabunewtuijian"] forState:UIControlStateNormal];
        [_btnFabuTuijian setBackgroundImage:[UIImage imageNamed:@"fabunewtuijian"] forState:UIControlStateHighlighted];
        
        [_btnFabuTuijian addTarget:self action:@selector(btnFabuCilick:) forControlEvents:UIControlEventTouchUpInside];
        //        _btnFabu.hidden = YES;
        _btnFabuTuijian.tag = 2;
        
//        [self.view addSubview:_btnFabuTuijian];
        
        
        _btnFabu = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnFabu.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 40, 40);
        _btnFabuJingcai.center = _btnFabu.center;
        _btnFabuTuijian.center = _btnFabu.center;
        [_btnFabu setBackgroundImage:[UIImage imageNamed:@"addJingcai"] forState:UIControlStateNormal];
        [_btnFabu setBackgroundImage:[UIImage imageNamed:@"addJingcaiS"] forState:UIControlStateSelected];
        
        [_btnFabu addTarget:self action:@selector(btnFabuCilick:) forControlEvents:UIControlEventTouchUpInside];
        _btnFabu.hidden = YES;
        _btnFabu.tag = 1;
        
        
//        [self.view addSubview:_btnFabu];
    
    }
    
    
    [self.view addSubview:self.liveQuizImageView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    if (_model.matchstate>0) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];

    }else if(_model.matchstate == 0){
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];

    }else{
    
    }
    
    if (self.isBack) {
        [self.analysisWeb reloadData];
        [self.recommendWeb reloadData];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadLiveData];
    });

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isBack = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
    
}

- (void)timerRun
{
    
    NSDate *matchDate = [Methods getDateFromString:_model.matchtime byformat:dateStyleFormatter];
    NSTimeInterval timerInt = [matchDate timeIntervalSince1970];
    NSTimeInterval timeNow = [[NSDate date] timeIntervalSince1970];
    NSInteger timeout= timerInt - timeNow;
//    if (timeout <= 60 *60 *24){
    
        
        if (timeout>0) {
            
        NSString *str_hour = [NSString stringWithFormat:@"%ld",timeout/3600];//时
            
            if (str_hour.length<=2) {
                str_hour =[NSString stringWithFormat:@"%02ld",timeout/3600];
            }
            
        NSString *str_minute = [NSString stringWithFormat:@"%02ld",(timeout%3600)/60];//分
        NSString *str_second = [NSString stringWithFormat:@"%02ld",timeout%60];//秒
        NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
            
            
            if ([str_hour integerValue]>24) {
                format_time = @"VS";
                [_timer invalidate];

            }
//        NSLog(@"time:%@",format_time);

        [_headerView changeCountTimeWithTime:format_time];
        }else{
        
            [_timer invalidate];
            [_headerView changeCountTimeWithTime:@"VS"];

            _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];

        }
        
//    }else{
//    
//        [_timer invalidate];
//    }
    
    
}
- (void)timerChange
{
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:[NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_change] Start:^(id requestOrignal) {
        [_timer setFireDate:[NSDate distantFuture]];

        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        NSArray *arrLiving = [LivingModel arrayOfEntitiesFromArray:responseOrignal];
        
        
        for (int i = 0; i<arrLiving.count; i++) {
            LivingModel *living = [arrLiving objectAtIndex:i];
            if (living.sid == _model.mid) {
                _model.matchstate = living.code;
                _model.homescore = living.hsc;
                _model.guestscore = living.gsc;
                _model.matchtime2 = living.htime;
                [_headerView updateScroeWithmodel:_model];
                if (_model.matchstate == -1 || _model.matchstate>0) {
                    _labVS.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
                }else{
                    _labVS.text = @"vs";
                    
                }
                if (_model.matchstate <0) {
                    [_timer invalidate];
                }
                
                break;
                
            }
        }
        
        [self performSelector:@selector(startTime) withObject:nil afterDelay:5];

        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        
        [self performSelector:@selector(startTime) withObject:nil afterDelay:5];

    }];
}


- (void)startTime
{
    [_timer setFireDate:[NSDate distantPast]];
    
}

#pragma mark -- setnavView
- (void)setNavView
{
    
    
    
    _nav = [[NavView alloc] init];
    _nav.delegate = self;
    
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
       _nav.bgView.alpha = 0;
    _nav.backgroundColor = [UIColor clearColor];
    
    
    _viewT = [[UIView alloc] initWithFrame:_nav.labTitle.frame];
    _viewT.alpha = 0;
    [_nav addSubview:_viewT];
    
    
    _labVS = [[UILabel alloc] init];
    _labVS.textColor = [UIColor whiteColor];
    _labVS.font = font16;
    if (_model.matchstate == -1 || _model.matchstate>0) {
        _labVS.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
    }else{
        _labVS.text = @"vs";

    }
    [_viewT addSubview:_labVS];
    
    [_labVS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewT.mas_centerY);
        make.centerX.equalTo(_viewT.mas_centerX);

    }];
    
    UILabel *labHome = [[UILabel alloc] init];
    labHome.textColor = [UIColor whiteColor];
    labHome.font = font16;
    labHome.text = _model.hometeam;
    labHome.textAlignment = NSTextAlignmentRight;
    [_viewT addSubview:labHome];
    
    [labHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewT.mas_centerY);
        make.right.equalTo(_labVS.mas_left).offset(-10);
        make.width.mas_equalTo(125*Scale_Ratio_width);
    }];

    
    
    UILabel *labGuest = [[UILabel alloc] init];
    labGuest.textColor = [UIColor whiteColor];
    labGuest.font = font16;
    labGuest.text = _model.guestteam;
    [_viewT addSubview:labGuest];
    
    [labGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_viewT.mas_centerY);
        make.left.equalTo(_labVS.mas_right).offset(10);
        make.width.mas_equalTo(125*Scale_Ratio_width);

    }];

    
    [self.view addSubview:_nav];
}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else if(index == 2){
        //right
        
        [self rightBtnClick];

    }
}

- (void)changeTableViewFrame
{
    self.mainTableCanscroll = YES;
    
//    self.webView.cellCanScroll = NO;
    self.analysisWeb.cellCanScroll = NO;
    self.webViewZhiShu.cellCanScroll = NO;
    self.webZhiBo.cellCanScroll = NO;
    self.NewQBTableView.cellCanScroll = NO;
    
//    self.tuiJianTable.cellCanScroll = NO;
    self.recommendWeb.cellCanScroll = NO;

}
- (void)updateHeaderData:(NSNotification *)notific
{
    NSArray *arrfenxiHeader = [notific.userInfo objectForKey:@"NSNotificationupdateHeaderData"];
    
    for (int i = 0; i<arrfenxiHeader.count; i++) {
        LiveScoreModel *liveModel = [arrfenxiHeader objectAtIndex:i];
        if (liveModel.mid == _headerView.model.mid) {
            _headerView.model = liveModel;
            break;
        }
        
    }
    
}


#pragma mark -- UITableViewDataSource

- (BifenDTTable *)tableView
{
    if (!_tableView) {
        _tableView = [[BifenDTTable alloc] initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStylePlain];
        _tableView.tag = 10;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [(self.model.weather) isEqualToString:@""]? 164 : 190;
    }
    return Height - 44 - APPDELEGATE.customTabbar.height_myNavigationBar;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return self.titleView;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        while ([cell.contentView.subviews lastObject]!= nil) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    
    if (indexPath.section == 0) {
        
        [cell.contentView addSubview:self.headerView];
//        [self.headerView addSubview:self.hederBottomView];
    }else{
        [cell.contentView addSubview:self.scrollMainView];
    }
    
    
    return cell;
    return nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (FenxiHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[FenxiHeaderView alloc] initWithFrame:CGRectMake(0, 0, Width, [(self.model.weather) isEqualToString:@""]? 164 : 190)]; // 160
        _headerView.model = self.model;
        _headerView.delegate = self;
    }
    return _headerView;
}

- (UIView *)hederBottomView {
    
    if (!_hederBottomView) {
        _hederBottomView = [[FenXiHeaderBottomView alloc] initWithFrame:CGRectMake(0, _headerView.bottom, Width, 40)];
        _hederBottomView.backgroundColor = redcolor;
    }
    return _hederBottomView;
}

- (void)backClick:(NSInteger)btnTag
{
    
    
    if (btnTag == 1) {
            [self.navigationController  popViewControllerAnimated:YES];

    }else{
        [self rightBtnClick];

    }
    

}

- (void)rightBtnClick
{
    
//    if (![Methods login]) {
//        [Methods toLogin];
//        return;
//    }

    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:_NewQBTableView.arrhomeInfo];
    [arr addObjectsFromArray:_NewQBTableView.arrneutralInfo];
    [arr addObjectsFromArray:_NewQBTableView.arrawayInfo];

    if (arr.count>0) {}
    
    
    
    
}




- (DCScrollVIew *)scrollMainView
{
    if (!_scrollMainView) {
        _scrollMainView = [[DCScrollVIew alloc] initWithFrame:CGRectMake(0, 0, Width, Height - 44 - APPDELEGATE.customTabbar.height_myNavigationBar)];;
        _scrollMainView.tag = 11;
        _scrollMainView.pagingEnabled = YES;
        _scrollMainView.delegate = self;
        _scrollMainView.bounces = NO;
        _scrollMainView.contentSize = CGSizeMake(Width*5, 0);
        _arrTableViews = [NSMutableArray array];

//        [self.scrollMainView addSubview:self.webView];
        [self.scrollMainView addSubview:self.analysisWeb];
        [self.scrollMainView addSubview:self.webViewZhiShu];
        [_scrollMainView addSubview:self.NewQBTableView];
        
//        [_scrollMainView addSubview:self.tuiJianTable];
        [_scrollMainView addSubview:self.recommendWeb];

        [_scrollMainView addSubview:self.webZhiBo];
        [self.webZhiBo addSegMent];
        
    }
    return _scrollMainView;
}
- (void)btnFabuCilick:(UIButton *)btn
{
    
    switch (btn.tag) {
        case 1:
        {
            
            if (btn.selected == YES) {
                
                
                _btnFabu.selected = NO;
                
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    
                    _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
                    _btnFabuJingcai.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 30, 30);
                    _btnFabuJingcai.center = _btnFabu.center;
                    _btnFabuTuijian.center = _btnFabu.center;
                    
                } completion:^(BOOL finished) {
                    
                }];

            }else{
            
                _btnFabu.selected = YES;
                
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    
                    _btnFabuTuijian.frame = CGRectMake(Width - 34 - 40 - 26 - 40, Height - 29 - 40, 70, 70);
                    _btnFabuJingcai.frame = CGRectMake(Width - 70 - 40, Height - 35 - 40 - 13 - 40, 40, 40);
                    
                    
                } completion:^(BOOL finished) {
                    
                }];

            }
            
            
            
            
        }
            break;
        case 2:
        {
            
            
            
            [UIView animateWithDuration:0.5 animations:^{
                
                
                _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
                _btnFabuJingcai.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 30, 30);
                _btnFabuJingcai.center = _btnFabu.center;
                _btnFabuTuijian.center = _btnFabu.center;
                
            } completion:^(BOOL finished) {
                
            }];
            
           
            
            _btnFabu.selected = NO;
            //发布推荐按钮
            if (![Methods login]) {
                [Methods toLogin];
                return;
            }
            
            [[DependetNetMethods sharedInstance] loadUserInfocompletion:^(UserModel *userback) {
                
                [self toapplyAnalasis];
            } errorMessage:^(NSString *msg) {
                [self toapplyAnalasis];
                
            }];
            

        }
            break;
        case 3:
        {
            
            _btnFabu.selected = NO;
            [UIView animateWithDuration:0.5 animations:^{
                
                
                _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
                _btnFabuJingcai.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 30, 30);
                _btnFabuJingcai.center = _btnFabu.center;
                _btnFabuTuijian.center = _btnFabu.center;
                
            } completion:^(BOOL finished) {
                
            }];

            
            if (![Methods login]) {
                [Methods toLogin];
                return;
            }
            
            Dan_StringMatchsModel *remodel = [Dan_StringMatchsModel entityFromDictionary:[NSDictionary dictionary]];
            
            remodel.sid = _model.mid;
            remodel.hometeam = _model.hometeam;
            remodel.guestteam = _model.guestteam;
            
//            SelectedNewJingcaiListVC *jingcaiVC = [[SelectedNewJingcaiListVC alloc] init];
//            jingcaiVC.hidesBottomBarWhenPushed = YES;
//            [APPDELEGATE.customTabbar pushToViewController:jingcaiVC animated:YES];
            

            
        }
            break;

        default:
            break;
    }
    
    
}
// 申请分析师
- (void)toapplyAnalasis
{
    UserModel *user = [Methods getUserModel];
    if (user.analyst == 1) {
        if (user.reachLimit == YES) {
            
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"周一~周五每天不超过5个方案，周六~周日每天不超过10个方案"];
            return;
        }
//        Dan_StringMatchsModel *remodel = [[Dan_StringMatchsModel alloc] init];
        Dan_StringMatchsModel *remodel = [Dan_StringMatchsModel entityFromDictionary:[NSDictionary dictionary]];
        remodel.sid = _model.mid;
        remodel.hometeam = _model.hometeam;
        remodel.guestteam = _model.guestteam;
        RelRecNewVC *relVC = [[RelRecNewVC alloc] init];
        relVC.model = remodel;
        relVC.hidesBottomBarWhenPushed = YES;
        
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
        //        [parameter setObject:@"2" forKey:@"flag"];
        // NSMutableDictionary *parameter=[NSMutableDictionary new];
        [parameter setObject:@(_model.mid) forKey:@"ScheduleID"];
        [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_SingalRecommendMatch] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
             NSLog(@"fatuijian判断=%@",responseOrignal);
            if ([[responseOrignal objectForKey:@"code"] integerValue]==200) {
                NSDictionary*data=[responseOrignal objectForKey:@"data"];
                NSDictionary*instantOdds=data[@"instantOdds"];
                NSArray*rq=instantOdds[@"rq"];
                NSArray*spf=instantOdds[@"spf"];
                NSArray*dx=instantOdds[@"dx"];
                if (rq.count == 0 && dx.count == 0 &&spf.count == 0) {
                    
                    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂无数据，无法发推荐！"];
                    return;
                }
                [APPDELEGATE.customTabbar pushToViewController:relVC animated:YES];
                

                
            }
            
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            return ;
        }];
        return;
        
}
    NSString *strTitle = @"您尚未认证分析师";
    NSString *str_content = @"申请分析师";
    
//    if (user.analyst == 1) {
//        strTitle = @"您的分析师认证资料未完善，请完善后再发推荐";
//        str_content = @"立即完善";
//    }
//    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:strTitle];
    [hogan addAttribute:NSFontAttributeName value:font16 range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:color33 range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedTitle"];
    
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:str_content style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ToAnalystsVC *analysts = [[ToAnalystsVC alloc] init];
        analysts.hidesBottomBarWhenPushed = YES;
        analysts.type = user.analyst;
        
        //        analysts.type = 3;
        
        
        analysts.model = user;
        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
        
    }];
    
    [alertOne setValue:redcolor forKey:@"_titleTextColor"];
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertTwo setValue:color33 forKey:@"_titleTextColor"];
    [alertController addAction:alertTwo];
    [alertController addAction:alertOne];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (NewQingbaoTableView *)NewQBTableView
{
    if (!_NewQBTableView) {
        _NewQBTableView = [[NewQingbaoTableView alloc] initWithFrame:CGRectMake(Width*2, 0, Width, _scrollMainView.height) style:UITableViewStylePlain];
        _NewQBTableView.tag = 32;
        _NewQBTableView.delegateNewQB = self;
        _NewQBTableView.backgroundColor = colorTableViewBackgroundColor;
    }
    return _NewQBTableView;
}
- (void)headerRefreshNewQB
{
    [self lodaDataAnalysisQB];
    
}
- (TuijianDatingTableView *)tuiJianTable
{
    if (!_tuiJianTable) {
        _tuiJianTable = [[TuijianDatingTableView alloc] initWithFrame:CGRectMake(Width*3, 0, Width, _scrollMainView.height) style:UITableViewStylePlain];
        _tuiJianTable.tag = 33;
        _tuiJianTable.type = typeTuijianCellFenxi;
        _tuiJianTable.hideFooter = YES;
        _tuiJianTable.model = self.model;
        _tuiJianTable.delegateTuijianDatingTableView = self;
        _tuiJianTable.backgroundColor = colorTableViewBackgroundColor;
    }
    return _tuiJianTable;
}

- (RecommendedWKWeb *)recommendWeb {
    if (_recommendWeb == nil) {
        _recommendWeb = [[RecommendedWKWeb alloc]initWithFrame:CGRectMake(Width*3, 0, Width, _scrollMainView.height)];
        WebModel *model = [[WebModel alloc]init];
        model.webUrl = [NSString stringWithFormat:@"%@/%@/tuijian-list.html?sid=%zi", APPDELEGATE.url_ip, H5_Host,_model.mid];
        _recommendWeb.model = model;
        _recommendWeb.tag = 33;
    }
    return _recommendWeb;
}

- (JiBenWebView *)webView{
    if (!_webView) {
        _webView = [[JiBenWebView alloc] initWithFrame:CGRectMake(0, 0, Width, _scrollMainView.height)];
        _webView.model = self.model;

        _webView.backgroundColor = colorTableViewBackgroundColor;
        _webView.scrollView.tag = 30;
    }
    
    return _webView;
}

- (AnalysisWebview *)analysisWeb {
    if (_analysisWeb == nil) {
        _analysisWeb = [[AnalysisWebview alloc]initWithFrame:CGRectMake(0, 0, Width, _scrollMainView.height)];
        WebModel *model = [[WebModel alloc]init];
        model.webUrl = [NSString stringWithFormat:@"%@/%@/fenxi/index.html#/?sid=%zi", APPDELEGATE.url_ip, H5_Host,_model.mid];
        _analysisWeb.model = model;
        _analysisWeb.tag = 30;
    }
    return _analysisWeb;
}




- (NewTuijianHtml *)webViewZhiShu{
    if (!_webViewZhiShu) {
        _webViewZhiShu = [[NewTuijianHtml alloc] initWithFrame:CGRectMake(Width, 0, Width, _scrollMainView.height)];
        if (self.segIndex) {
            _webViewZhiShu.segIndex = self.segIndex;
        }
        _webViewZhiShu.model = self.model;

        _webViewZhiShu.scrollView.tag = 31;

    }
    return _webViewZhiShu;
    
}



//- (NewZhiBoWebView *)webZhiBo{
//    if (!_webZhiBo) {
//        _webZhiBo = [[NewZhiBoWebView alloc] initWithFrame:CGRectMake(Width*4,0, Width, _scrollMainView.height)];
//        _webZhiBo.model = self.model;
//        _webZhiBo.scrollView.tag = 34;
//    }
//    return _webZhiBo;
//}

- (ZhiboTableView *)webZhiBo{
    if (!_webZhiBo) {
        _webZhiBo = [[ZhiboTableView alloc] initWithFrame:CGRectMake(Width*4,60, Width, _scrollMainView.height - 60)];
        _webZhiBo.model = _model;
        _webZhiBo.webSocket=self.webSocket;
        _webZhiBo.tag = 34;
        
    }
    return _webZhiBo;
}



- (TitleIndexView *)titleView
{
    if (!_titleView) {
        
        _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, Width, 44)];
        _titleView.backgroundColor = [UIColor whiteColor];
//        _titleView.selectedIndex = _selectedIndex;
        _titleView.bottomLineColor = colorDD;
        _titleView.arrData = @[@"分析",@"指数",@"情报",@"推荐",@"直播"];
        _titleView.delegate =self;

    }
    return _titleView;
}
#pragma mark -- TitlePagerViewDelegate
- (void)didSelectedAtIndex:(NSInteger)index;
{
    self.currentIndex = index;
    [self.titleView updateSelectedIndex:index];
    [self.scrollMainView setContentOffset:CGPointMake(_currentIndex * Width,0) animated:NO];
    _tableView.scrollEnabled = YES;
    if (index == 0) {
        [MobClick event:@"bsfx" label:@""];
    } else if (index == 1) {
        [MobClick event:@"bszs" label:@""];
    } else if (index == 2) {
        [MobClick event:@"bsqb" label:@""];
    } else if (index == 3) {
        [MobClick event:@"bstj" label:@""];
    } else if (index == 4) {
        [MobClick event:@"bszb" label:@""];
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView    // called when scroll view grinds to a halt
{
    
    
    if (scrollView.tag == 11) {
        _tableView.scrollEnabled = YES;
        NSInteger index = (NSInteger)(scrollView.contentOffset.x/Width);
        NSLog(@"%ld",(long)index);
        [self.titleView updateSelectedIndex:index];

    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_btnFabu.selected == YES) {
        
        
        _btnFabu.selected = NO;
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            _btnFabuTuijian.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 70, 70);
            _btnFabuJingcai.frame = CGRectMake(Width - 40 - 34, Height - 35 - 40 , 30, 30);
            _btnFabuJingcai.center = _btnFabu.center;
            _btnFabuTuijian.center = _btnFabu.center;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    if (scrollView.tag ==10) {
        
        if (scrollView.contentOffset.y<0) {
            scrollView.contentOffset = CGPointMake(0, 0);
            return;
        }
        
        
        
        
        CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y - 64;
        if (scrollView.contentOffset.y >= bottomCellOffset) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            if (self.mainTableCanscroll) {
                self.mainTableCanscroll = NO;
                
//                self.webView.cellCanScroll = YES;
                self.analysisWeb.cellCanScroll = YES;
                self.webViewZhiShu.cellCanScroll = YES;
                self.webZhiBo.cellCanScroll = YES;
                self.NewQBTableView.cellCanScroll = YES;
                
//                self.tuiJianTable.cellCanScroll = YES;
                self.recommendWeb.cellCanScroll = YES;
                
            }
        }else{
            if (!self.mainTableCanscroll) {//子视图没到顶部
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            }
        }
        self.tableView.showsVerticalScrollIndicator = self.mainTableCanscroll?YES:NO;

        _nav.bgView.alpha = scrollView.contentOffset.y*1.5/100 >1 ? 1:scrollView.contentOffset.y*1.5/100;
        _viewT.alpha = scrollView.contentOffset.y*1.5/100 >1 ? 1:scrollView.contentOffset.y*1.5/100;
        
    }else if (scrollView.tag == 11){
    
        
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        NSInteger num = contentOffsetX / Width;
        _currentIndex = num;

        if (_currentIndex == 2) {
            if (_isShareQB > 0) {
                self.headerView.imageRight.hidden = NO;
                _nav.btnRight.hidden = NO;
            }else{
                self.headerView.imageRight.hidden = YES;
                _nav.btnRight.hidden = YES;

            }
        }else{
            self.headerView.imageRight.hidden = YES;
            _nav.btnRight.hidden = YES;

        }
        
//        if (_currentIndex == 3) {
//            _btnFabu.hidden = NO;
//        }else{
//            _btnFabu.hidden = YES;
//        }
        _tableView.scrollEnabled = NO;
    }else if(scrollView.tag >= 30){
    
    
    
    }else{
    
    }
}
- (void)setsubvewCanscroll
{
    
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
}

#pragma mark ----- 请求提点的数据
- (void)lodaDataTiDian {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [dict setObject:@(self.model.mid) forKey:@"scheduleId"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:dict PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_tidian] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
                NSLog(@"提点%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _NewQBTableView.jiDianArr = [[NSMutableArray alloc] initWithArray:[TimeModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            
            [self.NewQBTableView reloadData];
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {

    }];
}

#pragma mark ----- 请求情报的数据
- (void)lodaDataAnalysisQB {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [dict setObject:@(self.model.mid) forKey:@"matchId"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:dict PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_infolistOneSchedule] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        //        NSLog(@"%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _NewQBTableView.arrhomeInfo = [[NSArray alloc] initWithArray:[InfoListModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"homeInfo"]]];
            _NewQBTableView.arrawayInfo = [[NSArray alloc] initWithArray:[InfoListModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"awayInfo"]]];
            _NewQBTableView.arrneutralInfo = [[NSArray alloc] initWithArray:[InfoListModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"neutralInfo"]]];
            _isShareQB = _NewQBTableView.arrhomeInfo.count + _NewQBTableView.arrawayInfo.count + _NewQBTableView.arrneutralInfo.count;
            if (_isShareQB > 0 && self.currentIndex == 2) {
                self.headerView.imageRight.hidden = NO;
                _nav.btnRight.hidden = NO;
            }else{
                self.headerView.imageRight.hidden = YES;
                _nav.btnRight.hidden = YES;
            }
            
            if (_NewQBTableView.arrawayInfo.count>0 ||  _NewQBTableView.arrneutralInfo.count>0 ||_NewQBTableView.arrhomeInfo.count>0 ) {
                //                    [self.view addSubview:self.btnShare];
            }
            _NewQBTableView.defaultTitle = @"暂无情报，你要做头条吗";
            _NewQBTableView.defaultPage =defaultPageThird;
            [_NewQBTableView reloadData];
            [_NewQBTableView.mj_header endRefreshing];
        }else{
            _NewQBTableView.defaultPage = defaultPageForth;
            _NewQBTableView.defaultTitle =  default_loadFailure;
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _NewQBTableView.defaultPage = defaultPageForth;
        _NewQBTableView.defaultTitle =  default_loadFailure;
    }];
}

#pragma mark -- 发不，先上传图片
- (void)uploadImageWithImageArr:(NSArray *)arrImage completion:(void(^)(BOOL finished,NSArray*arrUrl)) completion
{
    //    先上传图片，
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@(3) forKey:@"flag"];

    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_ZiXunUrl] ArrayFile:arrImage Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSArray *arr = [responseOrignal objectForKey:@"data"];
            NSMutableArray *arrPic = [NSMutableArray array];

            for (int i = 0; i < arr.count; i ++) {
                PictureModel *photoModel = [[PictureModel alloc] init];
                photoModel.imgthumburl = responseOrignal[@"data"][i][@"thumb"];
                photoModel.imageurl = responseOrignal[@"data"][i][@"image"];
                [arrPic addObject:photoModel];
            }
            
            completion(YES,arrPic);

        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            completion(NO,[NSArray array]);

        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        completion(NO,[NSArray array]);

    }];
    //
    
}


#pragma mark - ------

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
    NSMutableArray *activityArray = [ArchiveFile getDataWithPath:Activity_Path];
    if (activityArray.count > 0) {
        for (NSDictionary *dic in activityArray) {
            if (dic[@"matchDetail"]) {
                NSDictionary *itemDic = dic[@"matchDetail"];
                self.activityDic = itemDic;
                [self.liveQuizImageView sd_setImageWithURL:[NSURL URLWithString:itemDic[@"icon"]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.liveQuizImageView.hidden = false;
                });
                break;
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (self.model.matchstate ==0) {
                        self.liveQuizImageView.hidden = false;
                        self.liveQuizImageView.image = [UIImage imageNamed:@"fabunewtuijian"];
                    } else {
                        self.liveQuizImageView.hidden = YES;
                    }
                    
                });
            }
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.model.matchstate ==0) {
                self.liveQuizImageView.hidden = false;
                self.liveQuizImageView.image = [UIImage imageNamed:@"fabunewtuijian"];
            } else {
                self.liveQuizImageView.hidden = YES;
            }
        });
    }
    
}

#pragma mark - Events

- (void)liveQuziAction:(UITapGestureRecognizer *)tap {
    if (self.activityDic) {
        Class targetCalss = NSClassFromString(self.activityDic[@"n"]);
        ToolWebViewController *target =[[targetCalss alloc] init];
        WebModel *model = [[WebModel alloc]init];
        NSDictionary *pDic = self.activityDic[@"v"];
        model.title = PARAM_IS_NIL_ERROR(pDic[@"title"]);
        model.webUrl = PARAM_IS_NIL_ERROR(pDic[@"url"]);
        model.hideNavigationBar = pDic[@"nav_hidden"];
        model.parameter = pDic[@"nav"];
        target.model = model;
        [self.navigationController pushViewController:target animated:YES];
    } else {
        //发布推荐按钮
        if (![Methods login]) {
            [Methods toLogin];
            return;
        }
        
        [[DependetNetMethods sharedInstance] loadUserInfocompletion:^(UserModel *userback) {
            [self toapplyAnalasis];
        } errorMessage:^(NSString *msg) {
            [self toapplyAnalasis];
            
        }];
    }
    
}

#pragma mark - Lazy Load

- (UIImageView *)liveQuizImageView {
    if (_liveQuizImageView == nil) {
        _liveQuizImageView = [UIImageView new];
        _liveQuizImageView.frame = CGRectMake(Width - 80, 4 * (Height / 5), 70, 70);
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

- (ShowActivityView *)animationActivityView {
    if (_animationActivityView == nil) {
        _animationActivityView = [[ShowActivityView alloc]initWithFrame:CGRectMake(80, 4 * (Height / 5), 80, 80)];
    }
    return _animationActivityView;
}

@end
