//
//  NewQingBaoViewController.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/5/9.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "NewQingBaoViewController.h"
#import "NewQingBaoCell.h"
#import "FenxiPageVC.h"
#import "LiveScoreModel.h"
#import "QBNavigationVC.h"

#define aCell @"cellNewQingBaoViewController"

@interface NewQingBaoViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *arrAllDate;
@property (nonatomic,strong) MJRefreshAutoNormalFooter *footer;
@property (nonatomic, assign)NSInteger limitStart;
@property (nonatomic, strong)UITableViewCell *seleCell;
//是否正在请求跳转分析页的接口
@property (nonatomic, assign) BOOL isToFenxi;

@end

@implementation NewQingBaoViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[UMStatisticsMgr sharedInstance] viewStaticsBeginWithMarkStr:@"NewQingBaoViewController"];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
    [self setNavView];
    [self.view addSubview:self.tableView];
    [self setupHeader];
    [self setupFooter];
    _limitStart = 0;
    
     [self.tableView.mj_header beginRefreshing];

    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewContentOffsetZero) name:NotificationsetThirdTableViewContentOffsetZero object:nil];
    

    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[UMStatisticsMgr sharedInstance] viewStaticsEndWithMarkStr:@"NewQingBaoViewController"];
}
- (void)setTableViewContentOffsetZero{
    
    [self.tableView setContentOffset:CGPointZero animated:YES];
    
}
#pragma mark -- setnavView
- (void)setNavView{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"滚球情报";
//    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
//    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"QBNative"] forState:UIControlStateNormal];
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"QBNative"] forState:UIControlStateHighlighted];
    
    [nav.btnRight setTitle:@"比赛" forState:UIControlStateNormal];
    [nav.btnRight setTitle:@"比赛" forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}

#pragma mark ----------请求数据
- (void)loadData
{

    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@(_limitStart) forKey:@"limitStart"];
    [parameter setObject:@"20" forKey:@"limitNum"];

    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,@"/news/v1.2/infolist"] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        
//        self.defaultFailure = [responseOrignal objectForKey:@"msg"];
        
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
//            NSLog(@"%@",responseOrignal);
            if (_limitStart == 0) {
               _arrAllDate = [[NSMutableArray alloc] initWithArray:[QingBaoFPTwoModel arrayOfEntitiesFromArray: [responseOrignal objectForKey:@"data"]]];
            }else{
                NSArray *arr = [[NSMutableArray alloc] initWithArray:[QingBaoFPTwoModel arrayOfEntitiesFromArray: [responseOrignal objectForKey:@"data"]]];
                
                if (arr.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [_arrAllDate addObjectsFromArray:arr];
                }
            }
            
            self.defaultFailure = @"暂无情报，你要做头条吗";

        }else{
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];

            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            
        }

        [self.tableView reloadData];

        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;

        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];

        
    }];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[NewQingBaoCell class] forCellReuseIdentifier:aCell];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        //        [self setupTableViewMJHeader];
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
    
    if ([self.defaultFailure isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
        
    }
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"d1"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (void)setupHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataByHeader)];
    header.stateLabel.font = font13;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
}
- (void)setupFooter
{
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataByfooter)];
//    _footer.automaticallyHidden = YES;
}
#pragma mark ---- 下啦刷新
- (void)refreshDataByHeader{
    _limitStart = 0;
    [self loadData];
}
#pragma makr ---- 上拉加载
- (void)loadMoreDataByfooter{
     _limitStart += 20;
    [self loadData];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView.contentSize.height > tableView.frame.size.height) {
        tableView.mj_footer = _footer;
    }else{
        tableView.mj_footer = nil;
    }
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.contentSize.height > tableView.frame.size.height) {
        tableView.mj_footer = _footer;
    }else{
        tableView.mj_footer = nil;
    }
    
}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(index == 2){
        //right
        QBNavigationVC *navigat = [[QBNavigationVC alloc] init];
        navigat.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:navigat animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_arrAllDate.count == 0) {
        return 0;
    }
    
    return _arrAllDate.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//    return [tableView fd_heightForCellWithIdentifier:aCell cacheByIndexPath:indexPath configuration:^(NewQingBaoCell * cell) {
//        cell.model = _arrAllDate[indexPath.section];
//        
//    }];
    
    QingBaoFPTwoModel *model = _arrAllDate[indexPath.section];
    
    CGFloat heiContent = [Methods getTextHeightStationWidth:[NSString stringWithFormat:@"       %@",model.content] anWidthTxtt:Width - 30 anfont:14 andLineSpace:5.5 andHeaderIndent:0];
    if (heiContent > 84) {
        heiContent = 83.32;
    }
    CGFloat heiTitle = [Methods getTextHeightStationWidth:model.title anWidthTxtt:Width - 30 anfont:20 andLineSpace:5 andHeaderIndent:0];
    
    return   heiContent + heiTitle + 74;
    
//    return [tableView fd_heightForCellWithIdentifier:aCell configuration:^(NewQingBaoCell* cell) {
//        cell.model = _arrAllDate[indexPath.section];
//    }];
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewQingBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[NewQingBaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aCell];
    }
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = _arrAllDate[indexPath.section];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QingBaoFPTwoModel *_matchModel = [_arrAllDate objectAtIndex:indexPath.section];
    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)_matchModel.sid] toindex:2];
}
//跳转分析页
- (void)toFenxiWithMatchId:(NSString *)idID toindex:(NSInteger)index
{
    
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
    }else{
        
        return;
    }
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@"3" forKey:@"flag"];
    [parameter setObject:idID forKey:@"sid"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            LiveScoreModel *model = [LiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            //从情报页跳转分析页的时候不用反转
            model.neutrality = NO;
            FenxiPageVC *fenxiVC = [[FenxiPageVC alloc] init];
            fenxiVC.model = model;
            fenxiVC.currentIndex = index;
            fenxiVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
            
        }
        
        _isToFenxi = NO;
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _isToFenxi= NO;
    }];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
