
//
//  JishiViewController.m
//  GQapp
//
//  Created by WQ on 2016/12/21.
//  Copyright © 2016年 GQXX. All rights reserved.
//
#define  cellJishiViewController @"cellJishiViewController"
#import "JishiViewController.h"
#import "SaiguoViewController.h"
#import "SaichengViewController.h"
#import "GuanzhuViewController.h"
#import "HSJFoldHeaderView.h"

#import "GQWebView.h"

#import "SaiTableViewCell.h"
#import "LiveScoreModel.h"
#import "QiciModel.h"
#import "DCJishiBIifenView.h"
#import "DCPlaySound.h"
#import "BIfenSelectedSaishiModel.h"
#import "DCindexBtn.h"

#import "JSbifenModel.h"
static SystemSoundID shake_sound_id = 0;

@interface JishiViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,DCindexBtnDelegate,FoldSectionHeaderViewDelegate, GQWebViewDelegate>
@property (nonatomic, strong) NSArray *arrDataQici;
//当前页面请求之后保存的flag
@property (nonatomic, assign) NSInteger currentFlag;
@property (nonatomic, assign) NSInteger cellNum;

//定时任务，即时比分
//@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) dispatch_source_t  timer;

//比分提示
//@property (nonatomic, strong) MBProgressHUD *Hud;
//动画提示
@property (nonatomic, strong) MBProgressHUD *hud;
//动画展示的imageview
@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) DCJishiBIifenView *jsbfView;
@property (nonatomic, strong) DCindexBtn *indexBtn;
@property (nonatomic, strong) UITableViewCell *seleCell;
//定时器是否可以开启
@property (nonatomic, assign) BOOL timerOn;
@property (nonatomic, strong) NSMutableArray              *titleArr;
@property (nonatomic, strong) NSMutableDictionary         *foldInfo;


@property (nonatomic , strong) UIImageView *activityImageView;

@property (nonatomic , strong) GQWebView *activityWeb;

@property (nonatomic , copy) NSDictionary *activityDic;

@property (nonatomic , strong) UIButton *cloesBtn;

@end

@implementation JishiViewController

-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeTimer];
//    [self.timer setFireDate:[NSDate distantPast]];

//    _timerOn = YES;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadedBifenData"]) {
        
        //如果有黄条就不重新请求
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"youjinqiu"]) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self loadDataQiciJishiViewController];
                
//                [_timer setFireDate:[NSDate distantFuture]];
//                dispatch_resume(_timer);

            });
            
            
//            [self startTime];
        }
        
    }
    
    

    self.navigationController.navigationBarHidden = YES;
    
    // 活动入口
    [self loadRedBombActivity];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    //本地存储的选择的赛事（全部 竞猜 北单 足彩）
    //    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"_currentflag"];
    
    //允许即时比分页每次展示的时候加载数据，只是在这个页面初始化的时候设置一次
    self.defaultFailure = @"";
    [self.tableView.mj_header beginRefreshing];
    
    //没有筛选过，可以刷新数据，筛选过之后就不能在刷新数据了，每次出初始化的时候甚至为NO
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didSelectedbifen"];

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];

    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.indexBtn];
    
    [self addObserver:self forKeyPath:@"cellNum" options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewData) name:@"NotificationTogetAllJishibifen" object:nil];

    [self loadDataQiciJishiViewController];
    [self creatArr];

//    JsbfValue *model = [[JsbfValue alloc] init];
//    model.time = @"66";
//    model.league =@"赛事";
//    model.home = @"说发单数看风景阿拉丁阿斯蒂芬";
//    model.homeScore = @"2";
//    model.guest = @"说发单数看风景阿拉丁阿斯蒂芬";
//    model.guestScore = @"3";
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        // 更新界面
//        [[Methods getMainWindow] addSubview:self.jsbfView];
//        
//        self.jsbfView.isRed = NO;
//        self.jsbfView.ishome = NO;
//        self.jsbfView.model = model;
//        
//        
//    });
//    
//    
//    [self showJinqiuHud];
//
    
    
}



- (void)creatArr {
    
    _foldInfo = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                  @"0":@"1",
                                                                  @"1":@"1",
                                                                  @"2":@"1",
                                                                  }];
}

- (NSMutableArray *)titleArr {
    
    if (!_titleArr) {

        _titleArr = [NSMutableArray arrayWithObjects:@"比赛中",@"未开赛",@"已完场", nil];
    }
    return _titleArr;
}

- (void)getNewData
{
    
//    防止过期的比赛提示，去请求大对阵
    [self loadDataQiciJishiViewController];

//    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)refreshDataByChangeFlag:(NSInteger)flag
{
    _currentFlag = flag;
    [self loadDataQiciJishiViewController];
//    [_timer setFireDate:[NSDate distantFuture]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.s
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+14, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar -44 - APPDELEGATE.customTabbar.height_myTabBar-14) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        [_tableView registerClass:[SaiTableViewCell class] forCellReuseIdentifier:cellJishiViewController];
        [self setupHeaderView];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView reloadData];
    }
    return _tableView;
}

- (void)setupHeaderView {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = font13;
    
    self.tableView.mj_header = header;
}
- (void)headerRefreshData
{
    
//    for (JSbifenModel *jsModel in _arrData) {
//        
//        if (jsModel.data.count>0) {
//            
//            LiveScoreModel *live = [jsModel.data objectAtIndex:0];
//            LivingModel *living = [[LivingModel alloc] init];
//            living.hsc = (int)live.homescore +1;
//            living.homeRed = (int)live.homeRed + 1;
//            [self jinqiuShowHudWithLivingModel:living NowModel:live];
////                [self hongpaiShowHudLivingModel:living NowModel:live];
//
//            
//        }
//    }
////
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"didSelectedbifen"]) {
        [self loadDataQiciJishiViewController];

    }else{
        [self.tableView.mj_header endRefreshing ];
    }
    
//    [_timer setFireDate:[NSDate distantFuture]];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (_currentFlag == 0) {
//        
//        return 3;
//    }else{
//
    if (_arrData.count > 0 ) {
        
        return _arrData.count;
    }
    return 0;
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
    
//        return 40;
//    }
//    
//    if (_arrData.count>0) {
//        if (section == _arrData.count-1) {
//            return 0;
//        }
//        
//        JSbifenModel *model = [_arrData objectAtIndex:section];
//        if (model.data.count == 0) {
//            return 0;
//        }
//    }
//    return 30;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]&&(_currentFlag == 1||_currentFlag == 2||_currentFlag == 3)) {
        return 0;
    }else{
        JSbifenModel *model;
        if (_arrData.count > 0) {
            
           model = [_arrData objectAtIndex:section];
        }
        if (model.data.count == 0 ) {
            return 0;
        }else{
            
            return 40;
        }
    }
    return 0;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
       
        if (_arrData.count>0) {
            
            if (section == _arrData.count-1) {
                return nil;
            }
            
            JSbifenModel *model = [_arrData objectAtIndex:section];
            
            if (model.data.count == 0) {
                return nil;
            }else{
            
                UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 29)];
                header.backgroundColor = [UIColor whiteColor];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Width - 10, 29)];
                lab.textColor = color66;
                lab.font = font10;
                lab.text = [NSString stringWithFormat:@"%@ %ld场",model.time,model.data.count];
                [lab setAttributedText:[Methods withContent:lab.text WithColorText:[NSString stringWithFormat:@"% ld",model.data.count] textColor:redcolor strFont:font10]];
                
                [header addSubview:lab];
                
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 28.5, Width, 0.5)];
                line.backgroundColor = colorDD;
                [header addSubview:line];
                return header;
            }
        }
    }else{
        
        JSbifenModel *model;
        if (_arrData.count > 0 ) {
            
            model = [_arrData objectAtIndex:section];
        }
//
//    HSJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//    if (!headerView) {
//        headerView = [[HSJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
//    }
    HSJFoldHeaderView *headerView = [HSJFoldHeaderView new];
        headerView.contentView.backgroundColor = colorfbfafa;
    if (model.data.count == 0) {
        
        // [NSString stringWithFormat:@"%@(暂无)",self.titleArr[section]]
        [headerView setFoldSectionHeaderViewWithTitle:@"暂无" detail:@"" type:HerderStyleTotal section:section canFold:NO];
    }else{
    
        [headerView setFoldSectionHeaderViewWithTitle:[NSString stringWithFormat:@"%@(%ld)",model.time ,(unsigned long)model.data.count] detail:@"" type:HerderStyleTotal section:section canFold:YES];
    }
    
    headerView.delegate = self;
    
    if (section == 0) {
        
        headerView.titleColor = redcolor;
        headerView.clickView = [UIImage imageNamed:@""];
        if (model.data.count == 0) {

            headerView.roViewHided = YES;
        }else{
        
            headerView.roViewHided = NO;
        }
        headerView.isRedRo = YES;
    }else{
    
        headerView.titleColor = colorf66666;
        headerView.roViewHided = YES;
        headerView.isRedRo = NO;
    }
    headerView.lineHided = YES;
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    
    BOOL folded = [[_foldInfo valueForKey:key] boolValue];
    headerView.fold = folded;
    
    return headerView;
    }
    
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JSbifenModel *model;
    if (_arrData.count > 0 ) {
        
        model = [_arrData objectAtIndex:section];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
            
            self.cellNum = model.data.count;
            return model.data.count;
        }else{
            
            if (model.data.count==0) {
                
                self.cellNum = 0;
                return 0;
            }else{
                
                NSString *key = [NSString stringWithFormat:@"%d", (int)section];
                
                BOOL folded = [[_foldInfo objectForKey:key] boolValue];
                return folded? model.data.count :0;
            }
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellJishiViewController];
    if (!cell) {
        cell = [[SaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellJishiViewController];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    JSbifenModel *model;
    if (_arrData.count > 0) {
    
        model = [_arrData objectAtIndex:indexPath.section];
        cell.ScoreModel = [model.data objectAtIndex:indexPath.row];
    }
    
    
//    cell.contentView.backgroundColor = colorfbfafa;
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    cell.opaque = YES;
    cell.contentView.opaque = YES;
    
    if (_arrData.count > 1) {
        
        if (indexPath.section < model.data.count - 1) {
            
            UIView *marginView = [UIView new];
            marginView.backgroundColor = colorfbfafa;
            [cell.contentView addSubview:marginView];
            [marginView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.bottom.trailing.equalTo(cell.contentView);
                make.height.mas_equalTo(5);
            }];
        }
    }
    
    return cell;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_arrData.count > 0) {
        
        JSbifenModel *jsmodel = [_arrData objectAtIndex:indexPath.section];
        
        LiveScoreModel *model = [jsmodel.data objectAtIndex:indexPath.row];
        if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
            return 108;
        }
        return 80;
    }
    return 0;
}


- (DCindexBtn *)indexBtn
{
    if (!_indexBtn) {
        _indexBtn = [[DCindexBtn alloc] initWithFrame:CGRectMake(Width - 50, APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 29, 50, Height - (APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 29 + 49))];
        _indexBtn.delegate = self;
        _indexBtn.hidden= YES;
//        _indexBtn.backgroundColor = colorTableViewBackgroundColor;
    }
    return _indexBtn;
}

- (void)scrollToScale:(CGFloat)scaleY
{
    [self.tableView setContentOffset:CGPointMake(0, (self.tableView.contentSize.height - self.tableView.height)*scaleY) animated:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (_arrData.count>0) {
        _indexBtn.hidden = NO;

    }
    CGFloat scaleY = scrollView.contentOffset.y/(scrollView.contentSize.height - self.tableView.height);
    [_indexBtn updateScrollFrame:scaleY];
    
    
//    if (_timer != NULL) {
//        dispatch_suspend(_timer);
//    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideIndexBtn) object:nil];
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.00001];

}



// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
{

    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideIndexBtn) object:nil];
    //有nav时一开始的偏移量为-64，所以这里加上了64，如果是自定义nav则没有这种情况
    //    stopPosition = currentPostion + 64;
//    NSLog(@"滑动停止:%f",scrollView.contentOffset.y);
    [self performSelector:@selector(hideIndexBtn) withObject:nil afterDelay:2];
    
//    if (_timer != NULL) {
//        dispatch_resume(_timer);
//    }

}
- (void)hideIndexBtn
{
    _indexBtn.hidden = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    
  _seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    _seleCell.backgroundColor = colorF5;
    
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    _seleCell.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - KVO -
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    if([keyPath isEqualToString:@"cellNum"]) {
        
        if (self.cellNum == 0 ) {
        
//            self.defaultFailure = default_noMatch;
        }
    }
}

//返回单张图片
//Data Source 实现方法

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
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    if ([self.defaultFailure isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
        
    }
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    if (self.arrData.count == 0 ) {
        return [UIImage imageNamed:@"d1"];
    }
    return [UIImage imageNamed:@"d1"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = default_noMatch;
        
        NSDictionary *attributes;
        if (self.arrData.count == 0 ) {
            
            self.defaultFailure = default_noMatch;
            attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
        }else{
            
            attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        }
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}





- (void)loadDataQiciJishiViewController
{
    
    
    if (_currentFlag == 0) {
        
        QiciModel *qici = [[QiciModel alloc] init];
        qici.name = @"live";
        [self loadDataJishiViewControllerWithQici:qici];
        
    }else{
        
        
        NSString *urlStage = @"";
        
        switch (_currentFlag) {
            case 0:
            {
                urlStage = [NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_stageAll];
            }
                break;
            case 1:
            {
                urlStage = [NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_stageJC];
            }
                break;
            case 2:
            {
                urlStage = [NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_stageBD];
            }
                break;
            case 3:
            {
                urlStage = [NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_stageZC];
            }
                break;
            default:
                break;
        }
        
        
        [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:urlStage Start:^(id requestOrignal) {
            
//            [LodingAnimateView showLodingView];
        } End:^(id responseOrignal) {
            
//            [LodingAnimateView dissMissLoadingView];
        } Success:^(id responseResult, id responseOrignal) {
            self.defaultFailure = @"";
            _arrDataQici = [[NSArray alloc] initWithArray:[QiciModel arrayOfEntitiesFromArray:responseOrignal]];
            if (_arrDataQici.count == 0) {
                [_arrData removeAllObjects];
//                [self.tableView reloadData];
                [self reloadTableView];
                
                return ;
            }
            
            for (int i = 0; i<_arrDataQici.count; i++) {
                QiciModel *model = [_arrDataQici objectAtIndex:i];
                if (model.iscurrent == 1) {
                    
                    QiciModel *model = [_arrDataQici objectAtIndex:i];
                    [self loadDataJishiViewControllerWithQici:model];
                    break;
                }else{
                    if (i==_arrDataQici.count -1) {
                        QiciModel *model = [_arrDataQici objectAtIndex:i];
                        [self loadDataJishiViewControllerWithQici:model];
                        
                    }
                }
            }
            
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            self.defaultFailure = errorDict;

            [_arrData removeAllObjects];
            [self reloadTableView];
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];

        }];
        
    }
}

- (void)loadDataJishiViewControllerWithQici:(QiciModel *)model
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
        
//        NSString *urlStage = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_bifen_jsbfnew];
//        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
//        [parameter setObject:@(_currentFlag) forKey:@"type"];
//        

        NSString *urlJsbf = @"";
         switch (_currentFlag) {
         case 0:
         {
         NSString *urlLeague = @"";
         if (![[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaishijian"]) {
         urlLeague = @"league/";
         }
         
         urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_all,urlLeague,model.name,url_jsbf_json];
         NSLog(@"%@",urlJsbf);
         }
         break;
         case 1:
         {
         urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_jc,model.name,url_jsbf_json];
         }
         break;
         case 2:
         {
         urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_bd,model.name,url_jsbf_json];
         }
         break;
         case 3:
         {
         urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_zc,model.name,url_jsbf_json];
         }
         break;
         
         
         default:
         break;
         }
        
        
        dispatch_queue_t concurrentqueue=dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);//并行线程队列
        
        dispatch_async(concurrentqueue, ^{
            
            
            [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:urlJsbf Start:^(id requestOrignal) {
                
//                [LodingAnimateView showLodingView];
            } End:^(id responseOrignal) {
                [self.tableView.mj_header endRefreshing];

//                [LodingAnimateView dissMissLoadingView];
            } Success:^(id responseResult, id responseOrignal) {
                self.defaultFailure = @"";
//                if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                    //        NSLog(@"%@",responseOrignal);
                    NSMutableArray *arrLoad =[[NSMutableArray alloc] initWithArray:[JSbifenModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"matchs"]]];
                    _arrSelectedSaishi = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"allindex"]]];
                    _arrSelectedSaishiJingcai = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"jcindex"]]];
                    _arrSelectedSaishiChupan = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"oddsindex"]]];
                
                    //
                    NSMutableArray *arrComplete = [NSMutableArray array];
                    //
                    //            dispatch_queue_t queue= dispatch_queue_create("tim", DISPATCH_QUEUE_SERIAL);
                    
                    //            dispatch_async(queue, ^{
                    
                    
                    
                            for (int i = 0; i<_memeryArrAllPart.count; i++) {
                    
                                JSbifenModel *jsmodel = [_memeryArrAllPart objectAtIndex:i];
                    
                                for (int m= 0; m<jsmodel.data.count; m++) {
                    
                    
                    
                                    LiveScoreModel *model = [jsmodel.data objectAtIndex:m];
                    
                                    if (model.matchstate != 0){
                    
                    
                                        for (int j= 0; j<arrLoad.count; j++) {
                    
                                            JSbifenModel *jsloadmodel = [arrLoad objectAtIndex:j];
                    
                                            for (int n = 0; n<jsloadmodel.data.count; n++) {
                    
                                                LiveScoreModel *loadModel = [jsloadmodel.data objectAtIndex:n];
                    
                                                if (model.mid == loadModel.mid) {
                    
                                                    if (loadModel.matchstate != model.matchstate) {
                    
                    
                                                        if (!(loadModel.matchstate==0 ||loadModel.matchstate==1 ||loadModel.matchstate==2 ||loadModel.matchstate==3 ||
                                                              loadModel.matchstate==4)) {
                                                            //                                    [arrComplete addObject:loadModel];
                                                            [arrComplete addObject:loadModel];
                    
                                                        }
                    
                    
                                                        loadModel.matchstate = model.matchstate;
                    
                                                    }
                    
                                                    if (loadModel.homescore < model.homescore) {
                                                        loadModel.homescore = model.homescore;
                                                    }
                                                    if (loadModel.guestscore< model.guestscore) {
                                                        loadModel.guestscore = model.guestscore;
                                                    }
                    
                                                    if (loadModel.guestRed <model.guestRed) {
                                                        loadModel.guestRed = model.guestRed;
                                                    }
                                                    if (loadModel.homeRed <model.homeRed) {
                                                        loadModel.homeRed = model.homeRed;
                                                    }
                    
                                                    if (loadModel.guestYellow <model.guestYellow) {
                                                        loadModel.guestYellow = model.guestYellow;
                                                    }
                                                    if (loadModel.homeYellow <model.homeYellow) {
                                                        loadModel.homeYellow = model.homeYellow;
                                                    }
                    
                    
                                                    if (![loadModel.matchtime isEqualToString:model.matchtime]) {
                                                        loadModel.matchtime = model.matchtime;
                                                    }
                                                    if (![loadModel.matchtime2 isEqualToString:model.matchtime2]) {
                                                        loadModel.matchtime2 = model.matchtime2;
                                                    }
                    
                    
                    
                                                }
                    
                    
                                            }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                                        }
                                    }
                    
                                }
                    
                    
                    
                    
                            }
                
                    
                    
                    //            });
                    
                    
                    
                    
                    
                    
                    
                    
                    //重新写一个arr，防止是全部数据里面完场的比赛加到竞彩，北单，足彩里面
                    NSMutableArray *arrRemove = [NSMutableArray array];
                    
                    for (LiveScoreModel *completeModel in arrComplete) {
                        
                        for (int i = 0; i<arrLoad.count; i++) {
                            
                            JSbifenModel *jsmodel = [arrLoad objectAtIndex:i];
                            
                            if ([jsmodel.data containsObject:completeModel]) {
                                
                                [arrRemove addObject:completeModel];
                                [jsmodel.data removeObject:completeModel];
                                
                            }
                            
                        }
                        
                    }
                    
                    JSbifenModel *lastModel = [arrLoad lastObject];
                    [lastModel.data addObjectsFromArray:arrRemove];
                    
                    
                    //         如果是全部的赛事，就把内存中储存的大对阵换掉
                    if(0 == _currentFlag){
                        _memeryArrAllPart = [[NSMutableArray alloc] initWithArray:arrLoad];
                        
                    }
                    
                    
                    _arrData = [[NSMutableArray alloc] initWithArray:arrLoad];
                    [self seperateAlldateArrayByArray:_arrData];
                    
                    
                    [self reloadTableView];
                    
                    
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                    NSString *documentPath = [Methods getDocumentsPath];
                    NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
                    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
                    
                    NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
                    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
                    
                    NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
                    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
                    
                    
                    NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                    [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
                    
//                }
                
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                self.defaultFailure = errorDict;
                
                [_arrData removeAllObjects];
                //        [self.tableView reloadData];
                [self reloadTableView];
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
                
                NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
                
            }];
            
        });
        
    }else{
        
        NSString *urlStage = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_bifen_jsbfnew];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
        [parameter setObject:@(_currentFlag) forKey:@"type"];
        
        /*
         switch (_currentFlag) {
         case 0:
         {
         NSString *urlLeague = @"";
         if (![[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaishijian"]) {
         urlLeague = @"league/";
         }
         
         urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_all,urlLeague,model.name,url_jsbf_json];
         NSLog(@"%@",urlJsbf);
         }
         break;
         case 1:
         {
         urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_jc,model.name,url_jsbf_json];
         }
         break;
         case 2:
         {
         urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_bd,model.name,url_jsbf_json];
         }
         break;
         case 3:
         {
         urlJsbf = [NSString stringWithFormat:@"%@%@%@/%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_zc,model.name,url_jsbf_json];
         }
         break;
         
         
         default:
         break;
         }
         
         
         */
        
        
        dispatch_queue_t concurrentqueue=dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);//并行线程队列
        
        dispatch_async(concurrentqueue, ^{
            
            
            [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:urlStage Start:^(id requestOrignal) {
//                [LodingAnimateView showLodingView];

            } End:^(id responseOrignal) {
                [self.tableView.mj_header endRefreshing];

//                [LodingAnimateView dissMissLoadingView];
            } Success:^(id responseResult, id responseOrignal) {
                self.defaultFailure = @"";
                
                if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                    //        NSLog(@"%@",responseOrignal);
                    NSMutableArray *arrLoad =[[NSMutableArray alloc] initWithArray:[JSbifenModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"matchs"]]];
                    _arrSelectedSaishi = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"allindex"]]];
                    _arrSelectedSaishiJingcai = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[[responseOrignal  objectForKey:@"data"] objectForKey:@"jcindex"]]];
                    _arrSelectedSaishiChupan = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"oddsindex"]]];
                    
                    //
                    NSMutableArray *arrComplete = [NSMutableArray array];
                    //
                    //            dispatch_queue_t queue= dispatch_queue_create("tim", DISPATCH_QUEUE_SERIAL);
                    
                    //            dispatch_async(queue, ^{
                    
                    
                    
                            for (int i = 0; i<_memeryArrAllPart.count; i++) {
                    
                                JSbifenModel *jsmodel = [_memeryArrAllPart objectAtIndex:i];
                    
                                for (int m= 0; m<jsmodel.data.count; m++) {
                    
                    
                    
                                    LiveScoreModel *model = [jsmodel.data objectAtIndex:m];
                    
                                    if (model.matchstate != 0){
                    
                    
                                        for (int j= 0; j<arrLoad.count; j++) {
                    
                                            JSbifenModel *jsloadmodel = [arrLoad objectAtIndex:j];
                    
                                            for (int n = 0; n<jsloadmodel.data.count; n++) {
                    
                                                LiveScoreModel *loadModel = [jsloadmodel.data objectAtIndex:n];
                    
                                                if (model.mid == loadModel.mid) {
                    
                                                    if (loadModel.matchstate != model.matchstate) {
                    
                    
                                                        if (!(loadModel.matchstate==0 ||loadModel.matchstate==1 ||loadModel.matchstate==2 ||loadModel.matchstate==3 ||
                                                              loadModel.matchstate==4)) {
                                                            //                                    [arrComplete addObject:loadModel];
                                                            [arrComplete addObject:loadModel];
                    
                                                        }
                    
                    
                                                        loadModel.matchstate = model.matchstate;
                    
                                                    }
                    
                                                    if (loadModel.homescore < model.homescore) {
                                                        loadModel.homescore = model.homescore;
                                                    }
                                                    if (loadModel.guestscore< model.guestscore) {
                                                        loadModel.guestscore = model.guestscore;
                                                    }
                    
                                                    if (loadModel.guestRed <model.guestRed) {
                                                        loadModel.guestRed = model.guestRed;
                                                    }
                                                    if (loadModel.homeRed <model.homeRed) {
                                                        loadModel.homeRed = model.homeRed;
                                                    }
                    
                                                    if (loadModel.guestYellow <model.guestYellow) {
                                                        loadModel.guestYellow = model.guestYellow;
                                                    }
                                                    if (loadModel.homeYellow <model.homeYellow) {
                                                        loadModel.homeYellow = model.homeYellow;
                                                    }
                    
                    
                                                    if (![loadModel.matchtime isEqualToString:model.matchtime]) {
                                                        loadModel.matchtime = model.matchtime;
                                                    }
                                                    if (![loadModel.matchtime2 isEqualToString:model.matchtime2]) {
                                                        loadModel.matchtime2 = model.matchtime2;
                                                    }
                    
                    
                    
                                                }
                    
                    
                                            }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                                        }
                                    }
                    
                                }
                    
                    
                    
                    
                            }
                    
                    
                    
                    //            });
                    
                    
                    
                    
                    
                    
                    
                    
                    //重新写一个arr，防止是全部数据里面完场的比赛加到竞彩，北单，足彩里面
                    NSMutableArray *arrRemove = [NSMutableArray array];
                    
                    for (LiveScoreModel *completeModel in arrComplete) {
                        
                        for (int i = 0; i<arrLoad.count; i++) {
                            
                            JSbifenModel *jsmodel = [arrLoad objectAtIndex:i];
                            
                            if ([jsmodel.data containsObject:completeModel]) {
                                
                                [arrRemove addObject:completeModel];
                                [jsmodel.data removeObject:completeModel];
                                
                            }
                            
                        }
                        
                    }
                    
                    JSbifenModel *lastModel = [arrLoad lastObject];
                    [lastModel.data addObjectsFromArray:arrRemove];
                    
                    
                    //         如果是全部的赛事，就把内存中储存的大对阵换掉
                    if(0 == _currentFlag){
                        _memeryArrAllPart = [[NSMutableArray alloc] initWithArray:arrLoad];
                        
                    }
                    
                    
                    _arrData = [[NSMutableArray alloc] initWithArray:arrLoad];
                    [self seperateAlldateArrayByArray:_arrData];
                    
                    
                    [self reloadTableView];
                    
                    
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                    NSString *documentPath = [Methods getDocumentsPath];
                    NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
                    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
                    
                    NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
                    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
                    
                    NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
                    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
                    
                    
                    NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                    [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
                    
                }
                
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                self.defaultFailure = errorDict;
                
                [_arrData removeAllObjects];
                //        [self.tableView reloadData];
                [self reloadTableView];
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
                
                NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
                
            }];
            
        });
    }
}

//判断有没有正在进行中的比赛
- (void)seperateAlldateArrayByArray:(NSMutableArray *)arr
{
    /*
     type：比赛状态，（0:未开,1:上半场,2:中场,3:下半场,4,加时，-11:待定,-12:腰斩,-13:中断,-14:推迟,-1:完场，-10取消）
     
     */
    
    //    [self performSelector:@selector(startTimer) withObject:nil afterDelay:0];
    
    
    for (int i = 0; i<arr.count; i++) {
        
        
        JSbifenModel *jsmodel = [arr objectAtIndex:i];
        
        
        for (int j = 0; j<jsmodel.data.count; j++) {
            
            
            LiveScoreModel *model = [jsmodel.data objectAtIndex:j];
            if (!(model.matchstate == 1 |model.matchstate == 2 ||model.matchstate == 3||model.matchstate == 4))
            {
                //如果用正在进行中的比赛就开启定时器
//                [self performSelector:@selector(startTime) withObject:nil afterDelay:6];
//                [_timer setFireDate:[NSDate distantFuture]];
                break;
            }else{
                
            }
            
            
        }
        
        
        
    }
    
}

#pragma mark - FoldSectionHeaderViewDelegate -
- (void)foldHeaderInSection:(NSInteger)SectionHeader {
    
    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    
    BOOL folded = [[_foldInfo objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfo setValue:fold forKey:key];
    
    //    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:SectionHeader];
    //    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView reloadData];
}

- (void)changeTimer {
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue= dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(_timer, ^{

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self timerRun];
        });
    });
    
    dispatch_resume(_timer);
});

    
}


- (void)gcdTimer {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    
    //    dispatch_time_t start = dispatch_walltime(NULL, 0);
    
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    
    dispatch_source_set_timer(_timer, start, interval, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        
//            dispatch_source_cancel(_timer);
        
    });
    
    dispatch_resume(_timer);
    
}

/*

- (NSTimer *)timer
{
    if (!_timer) {
        
//        dispatch_queue_t queue= dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL);
//        
//        dispatch_async(queue, ^{
            _timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop currentRunLoop] run];
//            [_timer setFireDate:[NSDate distantFuture]];
            
//        });
        
        
    }
    return _timer;
}
 */
//获取即时比分
- (void)timerRun
{
    
    if ([[NSDate date] timeIntervalSince1970] > [[NSUserDefaults standardUserDefaults] doubleForKey:@"bifenchangeSaveTime"]) {
        
        [self loadDataQiciJishiViewController];
        
    }else{
        
//        dispatch_queue_t queue = dispatch_queue_create("hcios", NULL);
//
//        dispatch_async(queue, ^{
//
        
            [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:[NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_change] Start:^(id requestOrignal) {

//                [_timer setFireDate:[NSDate distantFuture]];
                
                
            } End:^(id responseOrignal) {
                
            } Success:^(id responseResult, id responseOrignal) {
                NSArray *arrLiving = [LivingModel arrayOfEntitiesFromArray:responseOrignal];
                
                
                
                NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
                
                
//                NSLog(@"arrLiving.count ---%ld",(unsigned long)arrLiving.count);
                
                [self changeLivingScoreWithData:arrLiving];
                
                
//                [self performSelector:@selector(startTime) withObject:nil afterDelay:5];
                
                
                
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                NSLog(@"%@",responseOrignal);
//                [self performSelector:@selector(startTime) withObject:nil afterDelay:5];
                NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
                
            }];
        
//        });
        
        
        
        
        
        
    }
}

//
//- (void)startTime
//{
//    
//    
//    
//    if (_timerOn) {
//        [self.timer setFireDate:[NSDate distantPast]];
//        
//    }
//    
//}

- (MBProgressHUD *)hud
{
    if (!_hud) {
        //        UINavigationController *nav = [APPDELEGATE.customTabbar.viewControllers objectAtIndex:1];
        //        UIViewController *ViewC = [nav.viewControllers firstObject];
        _hud = [[MBProgressHUD alloc] initWithView:[Methods getMainWindow]];
        _hud.mode= MBProgressHUDModeCustomView;
        _hud.animationType = MBProgressHUDAnimationFade;
        _hud.margin = 0;
        _hud.minShowTime = 3;
        //        _hud.dimBackground = YES;
        _hud.color = [UIColor clearColor];
        _hud.userInteractionEnabled = NO;
        
        UIView *basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        UIView *viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        viewBg.backgroundColor = [UIColor blackColor];
        viewBg.alpha = 0.5;
        [basicView addSubview:viewBg];
        
        //
        //        UIImageView *animateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        //        animateImageView.image = [UIImage imageNamed:@"defaultPic"];
        //        CABasicAnimation* rotationAnimation;
        //        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        //        rotationAnimation.duration = 1.5;
        //        rotationAnimation.cumulative = YES;
        //        rotationAnimation.repeatCount = MAXFLOAT;
        //        [animateImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        //        _hud.customView = animateImageView;
        
        NSMutableArray *arrImageV = [NSMutableArray array];
        for (int i = 0; i<8; i++) {
            [arrImageV addObject:[UIImage imageNamed:[NSString stringWithFormat:@"jinqiu%d",i]]];
        }
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Width/375*144)];
        _imageV.center = CGPointMake(Width/2, Height/2);
        _imageV.image = [UIImage imageNamed:@"jinqiu7"];
        _imageV.animationImages = arrImageV;
        _imageV.animationDuration = 1.5;
        _imageV.animationRepeatCount = 1;
        [_imageV startAnimating];
        [basicView addSubview:_imageV];
        _hud.customView = basicView;
        [[Methods getMainWindow] addSubview:_hud];
        
    }
    return _hud;
}

//- (MBProgressHUD *)Hud
//{
//    if (!_Hud) {
//        _Hud = [[MBProgressHUD alloc] initWithWindow:[Methods getMainWindow]];
//        _Hud.mode= MBProgressHUDModeCustomView;
//        _Hud.animationType = MBProgressHUDAnimationFade;
//        _Hud.margin = 0;
//        _hud.cornerRadius = 0;
//        _hud.opacity = 1;
//        _Hud.yOffset = self.tableView.height/2 - 50;
//        _Hud.userInteractionEnabled = NO;
//
//        [[Methods getMainWindow] addSubview:_Hud];
//
//    }
//    return _Hud;
//}

- (DCJishiBIifenView *)jsbfView
{
    if (!_jsbfView) {
        _jsbfView = [[DCJishiBIifenView alloc] initWithFrame:CGRectMake(20, Height - 49- 30 - 66, Width - 40, 66)];
        JsbfValue *value = [[JsbfValue alloc] init];
        _jsbfView.model = value;
        _jsbfView.userInteractionEnabled = NO;
        //        _jsbfView.alpha = 0;
        //        _jsbfView.hidden = YES;
        //        [[Methods getMainWindow] addSubview:_jsbfView];
    }
    return _jsbfView;
}
- (void)changeLivingScoreWithData:(NSArray *)arrLiving
{
    
    //    NSLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiu"]);
    
    //
    
    
    
    
    
    NSArray *arr = arrLiving;
    //需要刷新的cell
    NSMutableArray *arrlive = [[NSMutableArray alloc] init];
    //完场的比赛
    NSMutableArray *arrComplete = [NSMutableArray array];
    //需要通知到分析页去刷新新的数据
    NSMutableArray *arrSendFenxiPage = [NSMutableArray array];
    
    //        dispatch_queue_t queue= dispatch_queue_create("tim", DISPATCH_QUEUE_SERIAL);
    
    //        dispatch_async(queue, ^{
    
    if (self.arrData > 0 ) {
        
        for (int i = 0 ; i<self.arrData.count; i++) {
            
            JSbifenModel *jsmodel = [self.arrData objectAtIndex:i];
            
            
            for (int m = 0; m<jsmodel.data.count; m++) {
                
                LiveScoreModel * scoreModel= [jsmodel.data objectAtIndex:m];
                
                for (int j= 0; j<arr.count; j++){
                    LivingModel *livingModel = [arr objectAtIndex:j];
                    
                    //有比赛id相同,替换数据
                    if (scoreModel.mid == livingModel.sid) {
                        
                        if (scoreModel.matchstate != livingModel.code) {
                            
                            //完场的比赛需要放到最下边
                            if (!(livingModel.code == 0 ||livingModel.code == 1 || livingModel.code == 2 || livingModel.code == 3|| livingModel.code == 4)) {
                                
                                [arrComplete addObject:scoreModel];
                            }
                            
                            
                        }
                        
                        
                        
                        
                        NSString *documentsPath = [Methods getDocumentsPath];
                        NSString *arrayPath = [documentsPath stringByAppendingPathComponent:BifenPageAttentionArray];
                        NSMutableArray *arrAttention = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:arrayPath]];
                        
                        //是否是我关注的
                        BOOL isAttentioned = NO;
                        for (int i = 0; i<arrAttention.count; i++) {
                            NSInteger LmodelMid = [[arrAttention objectAtIndex:i] integerValue];
                            
                            if (LmodelMid == scoreModel.mid) {
                                isAttentioned = YES;
                                break;
                            }else{
                                isAttentioned = NO;
                            }
                        }
                        
                        
                        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"]) {
                            if (scoreModel.neutrality) {
                                LivingModel *change = [[LivingModel alloc] init];
                                change.homeRed = livingModel.guestRed;
                                change.homeYellow = livingModel.homeYellow;
                                change.hsc = livingModel.gsc;
                                change.gsc = livingModel.hsc;
                                
                                change.guestRed = livingModel.homeRed;
                                change.guestYellow = livingModel.homeYellow;
                                change.sid = livingModel.sid;
                                change.half = livingModel.half;
                                change.htime = livingModel.htime;
                                change.code = livingModel.code;
                                livingModel = change;
                            }
                            
                        }
                        
                        //开启夜间免打扰模式
                        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightStop"])
                        {
                            //在7点到23点之间的开启提示
                            if ([[[Methods getDateByDate:[NSDate date] withWeekType:weekTypeXingqi]objectAtIndex:3] intValue]>=7 && [[[Methods getDateByDate:[NSDate date] withWeekType:weekTypeXingqi]objectAtIndex:3] intValue]<=23)
                            {
                                //先判断是不是只提示我关注的
                                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"attentionMe"])
                                {
                                    
                                    if (isAttentioned)
                                    {
                                        //进球提示
                                        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"])
                                        {
                                            [self jinqiuShowHudWithLivingModel:livingModel NowModel:scoreModel];
                                        }
                                        //红牌
                                        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaitishi"])
                                        {
                                            [self hongpaiShowHudLivingModel:livingModel NowModel:scoreModel];
                                        }
                                    }
                                }else{
                                    //进球提示
                                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"])
                                    {
                                        [self jinqiuShowHudWithLivingModel:livingModel NowModel:scoreModel];
                                    }
                                    //红牌
                                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaitishi"])
                                    {
                                        [self hongpaiShowHudLivingModel:livingModel NowModel:scoreModel];
                                    }
                                }
                            }
                            
                        }else{//没有开启夜间免打扰模式
                            
                            //先判断是不是只提示我关注的
                            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"attentionMe"])
                            {
                                if (isAttentioned)
                                {
                                    //进球提示
                                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"])
                                    {
                                        [self jinqiuShowHudWithLivingModel:livingModel NowModel:scoreModel];
                                    }
                                    //红牌
                                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaishenying"])
                                    {
                                        [self hongpaiShowHudLivingModel:livingModel NowModel:scoreModel];
                                    }
                                }
                            }else{
                                //进球提示
                                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"])
                                {
                                    [self jinqiuShowHudWithLivingModel:livingModel NowModel:scoreModel];
                                }
                                //红牌
                                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaishenying"])
                                {
                                    [self hongpaiShowHudLivingModel:livingModel NowModel:scoreModel];
                                }
                            }
                        }
                        //设置
                        /************************************************************/
                        
                        //比分红黄牌反转,(在上面已经把change 里面的反转过了,所以呀更换收据的时候只需要把没有做过反转的半场比分反转即可)
                        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"]) {
                            if (scoreModel.neutrality) {
                                
                                if (livingModel.half != nil && ![livingModel.half isEqualToString:@""]) {
                                    
                                    NSArray *half = [livingModel.half componentsSeparatedByString:@"-"];
                                    scoreModel.homehalfscore = [[half objectAtIndex:1] intValue];
                                    scoreModel.guesthalfscore = [[half objectAtIndex:0] intValue];
                                }
                                
                                
                            }else{
                                if (livingModel.half != nil && ![livingModel.half isEqualToString:@""]) {
                                    
                                    NSArray *half = [livingModel.half componentsSeparatedByString:@"-"];
                                    scoreModel.homehalfscore = [[half objectAtIndex:0] intValue];
                                    scoreModel.guesthalfscore = [[half objectAtIndex:1] intValue];
                                }
                            }
                            
                        }else{
                            
                            if (livingModel.half != nil && ![livingModel.half isEqualToString:@""]) {
                                
                                NSArray *half = [livingModel.half componentsSeparatedByString:@"-"];
                                scoreModel.homehalfscore = [[half objectAtIndex:0] intValue];
                                scoreModel.guesthalfscore = [[half objectAtIndex:1] intValue];
                            }
                        }
                        
                        if (scoreModel.homescore <livingModel.hsc) {
                            scoreModel.homescore = livingModel.hsc;
                            
                        }
                        if (scoreModel.homeRed <livingModel.homeRed) {
                            scoreModel.homeRed = livingModel.homeRed;
                            
                        }
                        
                        if (scoreModel.homeYellow <livingModel.homeYellow) {
                            scoreModel.homeYellow = livingModel.homeYellow;
                            
                        }
                        if (scoreModel.guestscore <livingModel.gsc) {
                            scoreModel.guestscore = livingModel.gsc;
                            
                        }
                        if (scoreModel.guestRed <livingModel.guestRed) {
                            scoreModel.guestRed = livingModel.guestRed;
                            
                        }
                        if (scoreModel.guestYellow <livingModel.guestYellow) {
                            scoreModel.guestYellow = livingModel.guestYellow;
                            
                        }
                        
                        scoreModel.matchstate = livingModel.code;
                        
                        
                        if (livingModel.code == 1 ) {
                            scoreModel.matchtime2 = livingModel.htime;
                        }else if (livingModel.code == 2){
                            scoreModel.matchtime2 = livingModel.htime;
                        }else if (livingModel.code == 3){
                            scoreModel.matchtime2 = livingModel.htime;
                        }else if (livingModel.code == 4){
                            scoreModel.matchtime2 = livingModel.htime;
                        }
                        
                        
                        NSIndexPath *path = [NSIndexPath indexPathForRow:m inSection:i];
                        [arrlive addObject:path];
                        
                        [arrSendFenxiPage addObject:scoreModel];
                    }
                }
                
            }
            
            
            
            
            
        }
    }
    
    
    
    //        });
    
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationupdateHeaderData" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSendFenxiPage,@"NSNotificationupdateHeaderData", nil]];
    
    
    if (arrlive.count >0) {
        NSLog(@"all ---arrlive.count----%ld",(unsigned long)arrlive.count);
        
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            // 更新界面
        //            [self.tableView reloadRowsAtIndexPaths:arrlive withRowAnimation:UITableViewRowAnimationNone];
        //
        //
        //        });
        
        [self reloadTableView];
        
    }
    
    
    //    dispatch_async(queue, ^{
    
    
    //    更新内存中存放的全部对阵数据的内容
    for (int i = 0 ; i<self.arrData.count; i++) {
        
        JSbifenModel *jsmodel = [self.arrData objectAtIndex:i];
        
        
        for (int m = 0; m<jsmodel.data.count; m++) {
            
            LiveScoreModel * scoreModel= [jsmodel.data objectAtIndex:m];
            
            for (int j= 0; j<_memeryArrAllPart.count; j++){
                
                JSbifenModel *jsMMmodel = [_memeryArrAllPart objectAtIndex:j];
                
                
                for (int n = 0; n<jsMMmodel.data.count; n++) {
                    
                    
                    LiveScoreModel *mmModel = [jsMMmodel.data objectAtIndex:n];
                    
                    //有比赛id相同,替换数据
                    if (scoreModel.mid == mmModel.mid) {
                        
                        mmModel = scoreModel;
                        
                    }
                    
                }
            }
        }
    }
    
    
    //    });
    
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^{
    
    
    
    //把完场的比赛放到最后面
    //重新写一个arr，防止是全部数据里面完场的比赛加到竞彩，北单，足彩里面
    NSMutableArray *arrRemove = [NSMutableArray array];
            for (LiveScoreModel *model in arrComplete) {
    
                for (int i = 0; i<self.arrData.count; i++) {
                    JSbifenModel *jsmodel = [self.arrData objectAtIndex:i];
    
                    if ([jsmodel.data containsObject:model]) {
                        [arrRemove addObject:model];
                        [jsmodel.data removeObject:model];
    
                    }
    
                }
    
    
    
            }
    
    JSbifenModel *jsmodel= [self.arrData lastObject];
    [jsmodel.data addObjectsFromArray:arrRemove];
    
    if (arrComplete.count>0) {
        [self reloadTableView];
        
    }
    
    
    
    
    //    });
    
    
}
//进球提示
- (void)jinqiuShowHudWithLivingModel:(LivingModel *)livingModel NowModel:(LiveScoreModel *)scoreModel
{
    
    if (livingModel.hsc > scoreModel.homescore) {
        scoreModel.homescore =livingModel.hsc;
        
        
        
        JsbfValue *model = [[JsbfValue alloc] init];
        model.time = [self getLivetime:scoreModel];
        model.league =scoreModel.league;
        model.home = scoreModel.hometeam;
        model.homeScore = [NSString stringWithFormat:@"%ld",(long)livingModel.hsc];
        model.guest = scoreModel.guestteam;
        model.guestScore = [NSString stringWithFormat:@"%ld",(long)livingModel.gsc];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiutanchuan"] || [[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaitanchuang"]) {
                
                [[Methods getMainWindow] addSubview:self.jsbfView];
            }
            self.jsbfView.isRed = NO;
            self.jsbfView.ishome = YES;
            self.jsbfView.model = model;
            
        });
        //        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"]) {
        [self musicShowJinqiu];
        
        //        }else{
        
        //        }
        
        
        [self showJinqiuHud];
        [self hideJinqiuHudAfterSeconds:10];
        //
        
        
        if (APPDELEGATE.customTabbar.selectedIndex == 1) {
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showJinqiuAnimation"]) {
                
                //                [self.hud show:YES];
                //                [_imageV startAnimating];
                //
                //                [self.hud hide:YES afterDelay:3];
                
            }
            
            
            
        }
        
        
        scoreModel.bgIsRed = YES;
        [self reloadTableView];
        //进球10秒之后才可以显示界面的时候加载数据，否则显示进球的黄条就没有了
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"youjinqiu"];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 10*NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            scoreModel.bgIsRed = NO;
            [self.tableView reloadData];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
            
            
        });
        
        
        
    }
    if (livingModel.gsc > scoreModel.guestscore) {
        scoreModel.guestscore = livingModel.gsc;
        //        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"]) {
        [self musicShowJinqiu];
        
        //        }else{
        
        //        }
        JsbfValue *model = [[JsbfValue alloc] init];
        model.time = [self getLivetime:scoreModel];
        model.league =scoreModel.league;
        model.home = scoreModel.hometeam;
        model.homeScore = [NSString stringWithFormat:@"%ld",(long)livingModel.hsc];
        model.guest = scoreModel.guestteam;
        model.guestScore = [NSString stringWithFormat:@"%ld",(long)livingModel.gsc];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [[Methods getMainWindow] addSubview:self.jsbfView];
            
            self.jsbfView.isRed = NO;
            self.jsbfView.ishome = NO;
            self.jsbfView.model = model;
            
            
        });
        
        
        [self showJinqiuHud];
        [self hideJinqiuHudAfterSeconds:10];
        
        
        
        if (APPDELEGATE.customTabbar.selectedIndex == 1) {
            
            
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showJinqiuAnimation"]) {
                
                //                [self.hud show:YES];
                //                [_imageV startAnimating];
                //
                //                [self.hud hide:YES afterDelay:3];
                
            }
            
        }
        
        
        
        
        scoreModel.bgIsRed = YES;
        [self reloadTableView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"youjinqiu"];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 10*NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            scoreModel.bgIsRed = NO;
            [self.tableView reloadData];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
            
            
        });
        
    }
    
    
    
}

- (void)reloadTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更新界面
        
        
        [self.tableView reloadData];
        
        
    });
    
}

//红牌提示
- (void)hongpaiShowHudLivingModel:(LivingModel *)livingModel NowModel:(LiveScoreModel *)scoreModel
{
    if (livingModel.homeRed >scoreModel.homeRed) {
        scoreModel.homeRed = livingModel.homeRed;
        scoreModel.guestRed = livingModel.guestRed;
        //        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaishenying"]) {
        [self musicShowRed];
        
        //        }else{
        
        //        }
        
        scoreModel.homeRed = livingModel.homeRed;
        scoreModel.guestRed = livingModel.guestRed;
        
        JsbfValue *model = [[JsbfValue alloc] init];
        model.time = [self getLivetime:scoreModel];
        model.league =scoreModel.league;
        model.RedTeam = scoreModel.hometeam;
        model.home = scoreModel.hometeam;
        model.guest = scoreModel.guestteam;
        model.redHome = [NSString stringWithFormat:@"%ld",(long)livingModel.homeRed];
        model.redGuest = [NSString stringWithFormat:@"%ld",(long)livingModel.guestRed];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [[Methods getMainWindow] addSubview:self.jsbfView];
            
            self.jsbfView.isRed = YES;
            self.jsbfView.ishome = YES;
            self.jsbfView.model = model;
            
            
        });
        
        
        [self showJinqiuHud];
        [self hideJinqiuHudAfterSeconds:10];
    }
    if (livingModel.guestRed > scoreModel.guestRed) {
        
        //        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaishenying"]) {
        [self musicShowRed];
        
        //        }else{
        
        //        }
        
        
        scoreModel.homeRed = livingModel.homeRed;
        scoreModel.guestRed = livingModel.guestRed;
        JsbfValue *model = [[JsbfValue alloc] init];
        model.time = [self getLivetime:scoreModel];
        model.league =scoreModel.league;
        model.RedTeam = scoreModel.guestteam;
        model.home = scoreModel.hometeam;
        model.guest = scoreModel.guestteam;
        model.redHome = [NSString stringWithFormat:@"%ld",(long)livingModel.homeRed];
        model.redGuest = [NSString stringWithFormat:@"%ld",(long)livingModel.guestRed];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [[Methods getMainWindow] addSubview:self.jsbfView];
            
            self.jsbfView.isRed = YES;
            self.jsbfView.ishome = NO;
            
            self.jsbfView.model = model;
            
            
        });
        
        [self showJinqiuHud];
        [self hideJinqiuHudAfterSeconds:10];
    }
}

- (void)musicShowRed
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaishenying"]) {
        
        NSString *path = nil;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"huanhu"]) {
            
            path = [[NSBundle mainBundle] pathForResource:@"music11" ofType:@"wav"];
        }else if([[NSUserDefaults standardUserDefaults] boolForKey:@"koushao"]){
            
            path = [[NSBundle mainBundle] pathForResource:@"music1" ofType:@"wav"];
        }
        if (path) {
            //注册声音到系统
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_id);
            AudioServicesPlaySystemSound(shake_sound_id);
            //        AudioServicesPlaySystemSound(shake_sound_id);//如果无法再下面播放，可以尝试在此播放
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaizhendong"]) {
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
        }
        //    AudioServicesPlaySystemSound(shake_sound_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
        
        //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
        
        
    }else{
        
        // 不需要声音
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaizhendong"]) {
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
        }
    }
    
}

- (void)musicShowJinqiu
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"]) {
        
        NSString *path = nil;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"huanhu"]) {
            
            path = [[NSBundle mainBundle] pathForResource:@"music11" ofType:@"wav"];
        }else if([[NSUserDefaults standardUserDefaults] boolForKey:@"koushao"]){
            
            path = [[NSBundle mainBundle] pathForResource:@"music1" ofType:@"wav"];
        }
        if (path) {
            //注册声音到系统
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_id);
            AudioServicesPlaySystemSound(shake_sound_id);
            //        AudioServicesPlaySystemSound(shake_sound_id);//如果无法再下面播放，可以尝试在此播放
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
        }
        //    AudioServicesPlaySystemSound(shake_sound_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
        
        //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
        
        
    }else{
        
        // 不需要声音
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
        }
    }
    
}

//获取比赛的时间
- (NSString *)getLivetime:(LiveScoreModel *)scoreModel
{
    NSString *time = [Methods getDateByStyle:dateStyleFormatter withDate:[NSDate date]];
    
    switch (scoreModel.matchstate) {
        case 0:
        {
            return @"0";
        }
            break;
        case 1:
        {
            //上半场
            NSString *timeCha =[Methods intervalFromLastDate:scoreModel.matchtime2 toTheDate:time];
            
            if ([timeCha isEqualToString:@"0"]) {
                return @"1";
            }else{
                if ([timeCha intValue]>45) {
                    return @"45+";
                    
                }else{
                    
                    return timeCha;
                }
            }
        }
            break;
        case 2:
        {
            //中场
            return  @"中场";
            
        }
            break;
        case 3:
        {
            //下半场
            NSString *timeCha = [Methods intervalFromLastDateAnd45:scoreModel.matchtime2 toTheDate:time];
            if ([timeCha intValue]>90) {
                return  @"90+";
            }else if ([timeCha intValue] == 45){
                return  @"46";
            }
            else{
                return  timeCha;
            }
            
        }
            break;
        case 4:
        {
            return  [Methods intervalFromLastDateAnd45:scoreModel.matchtime2 toTheDate:time];
            
        }
            break;
            
        default:
        {
            return  @"0";
            
        }
            break;
    }
    
    
}



- (void)showJinqiuHud
{
    
    
    
    //    [UIView animateWithDuration:0.5 animations:^{
    //    }];
}

- (void)hideJinqiuHudAfterSeconds:(NSInteger)sec
{
    
    
    //    [UIView animateWithDuration:0.5 animations:^{
    //    }completion:^(BOOL finished) {
    //    }];
    //
    //
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.jsbfView removeFromSuperview];
        self.jsbfView = nil;
        
        
    });
    
    
}







- (void)staybifen
{
    
    
}
//{
//    //                NSLog(@"%@",responseOrignal);
//    NSMutableArray *arrLoad =[[NSMutableArray alloc] initWithArray:[LiveScoreModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"matchs"]]];
//    _arrSelectedSaishi = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"allindex"]]];
//    _arrSelectedSaishiJingcai = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"jcindex"]]];
//    _arrSelectedSaishiChupan = [[NSArray alloc] initWithArray:[BIfenSelectedSaishiModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"oddsindex"]]];
//
//    //
//    NSMutableArray *arrComplete = [NSMutableArray array];
//    for (int i = 0; i<_memeryArrAllPart.count; i++) {
//        LiveScoreModel *model = [_memeryArrAllPart objectAtIndex:i];
//
//        if (model.matchstate != 0){
//
//            for (int j= 0; j<arrLoad.count; j++) {
//
//                LiveScoreModel *loadModel = [arrLoad objectAtIndex:j];
//
//                if (model.mid == loadModel.mid) {
//
//                    if (loadModel.matchstate != model.matchstate) {
//                        loadModel.matchstate = model.matchstate;
//                    }
//
//                    if (loadModel.homescore < model.homescore) {
//                        loadModel.homescore = model.homescore;
//                    }
//                    if (loadModel.guestscore< model.guestscore) {
//                        loadModel.guestscore = model.guestscore;
//                    }
//
//                    if (loadModel.guestRed <model.guestRed) {
//                        loadModel.guestRed = model.guestRed;
//                    }
//                    if (loadModel.homeRed <model.homeRed) {
//                        loadModel.homeRed = model.homeRed;
//                    }
//
//                    if (loadModel.guestYellow <model.guestYellow) {
//                        loadModel.guestYellow = model.guestYellow;
//                    }
//                    if (loadModel.homeYellow <model.homeYellow) {
//                        loadModel.homeYellow = model.homeYellow;
//                    }
//
//
//                    if (![loadModel.matchtime isEqualToString:model.matchtime]) {
//                        loadModel.matchtime = model.matchtime;
//                    }
//                    if (![loadModel.matchtime2 isEqualToString:model.matchtime2]) {
//                        loadModel.matchtime2 = model.matchtime2;
//                    }
//
//                    if (!(loadModel.matchstate==0 ||loadModel.matchstate==1 ||loadModel.matchstate==2 ||loadModel.matchstate==3 ||
//                          loadModel.matchstate==4)) {
//                        [arrComplete addObject:loadModel];
//
//                    }
//
//
//                }
//            }
//        }
//
//    }
//
//    //重新写一个arr，防止是全部数据里面完场的比赛加到竞彩，北单，足彩里面
//    NSMutableArray *arrRemove = [NSMutableArray array];
//
//    for (LiveScoreModel *completeModel in arrComplete) {
//        if ([arrLoad containsObject:completeModel]) {
//            [arrRemove addObject:completeModel];
//            [arrLoad removeObject:completeModel];
//        }
//    }
//
//
//    [arrLoad addObjectsFromArray:arrRemove];
//
//
//    //         如果是全部的赛事，就把内存中储存的大对阵换掉
//    if(0 == _currentFlag){
//        _memeryArrAllPart = [[NSMutableArray alloc] initWithArray:arrLoad];
//
//    }
//
//
//    _arrData = [[NSMutableArray alloc] initWithArray:arrLoad];
//    [self seperateAlldateArrayByArray:_arrData];
//
//    [self.tableView reloadData];
//
//
//
//
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
//    NSString *documentPath = [Methods getDocumentsPath];
//    NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
//    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
//
//    NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
//    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
//
//    NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
//    [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
//
//
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark -  活动入口

#pragma mark - GQWebViewDelegate

- (void)webClose:(id)data {
    if (_activityWeb) {
        [_activityWeb removeFromSuperview];
        _activityWeb = nil;
    }
}

- (void)loadRedBombActivity {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_redBomb]  Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        NSString *code = responseOrignal[@"code"];
        if ([code isEqualToString:@"200"]) {
            NSDictionary *itemDic = responseOrignal[@"data"];
            if (itemDic) {
                self.activityDic = itemDic;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addActivityWith:itemDic];
                });
            }
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addActivityWith:nil];
            });
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addActivityWith:nil];
        });
    }];
    
}

- (void)addActivityWith:(NSDictionary *)dataDic {
    if ([dataDic isKindOfClass:[NSDictionary class]]) {
        if (!_activityImageView) {
            [self.view addSubview:self.activityImageView];
            CGRect rect = self.tableView.frame;
            rect.origin.y = rect.origin.y + 66;
            rect.size.height = rect.size.height - 66;
            self.tableView.frame = rect;
        }
        [self.activityImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"picture"]]];
        
    } else {
        if (_activityImageView) {
            [_activityImageView removeFromSuperview];
            _activityImageView = nil;
        }
        self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+14, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar -44 - APPDELEGATE.customTabbar.height_myTabBar-14);
    }
}

#pragma mark - Events

- (void)redBombActivity:(UIGestureRecognizer *)tap {
    if (self.activityDic) {
        if (![Methods login]) {
            [Methods toLogin];
            return;
        }
        [MobClick event:@"yhb3" label:@""];
        WebModel *model = [[WebModel alloc]init];
        model.title = PARAM_IS_NIL_ERROR(self.activityDic[@"title"]);
        model.webUrl = PARAM_IS_NIL_ERROR(self.activityDic[@"activityUrl"]);
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
    } else {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"活动不可用"];
    }
}

- (void)closeActivity {
    [self addActivityWith:nil];
}

#pragma mark - Lazy Load

- (UIImageView *)activityImageView {
    if (_activityImageView == nil) {
        _activityImageView = [UIImageView new];
        _activityImageView.frame = CGRectMake(0, 118, Width, 66);
        _activityImageView.contentMode = UIViewContentModeScaleAspectFill;
        _activityImageView.clipsToBounds = YES;
        _activityImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(redBombActivity:)];
        [_activityImageView addGestureRecognizer:tap];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"redbombclose"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeActivity) forControlEvents:UIControlEventTouchUpInside];
        [_activityImageView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_activityImageView.mas_top).offset(5);
            make.right.equalTo(_activityImageView.mas_right).offset(-5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
    }
    return _activityImageView;
}


@end
