//
//  ZBQBNavigationVC.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/30.
//  Copyright © 2017年 GQXX. All rights reserved.
//


#import "ZBQBNavigationVC.h"
#import "ZBQBNavigatCell.h"
#import "ZBNavigationModel.h"
#import "ZBFenxiPageVC.h"
#import "ZBLiveScoreModel.h"

@interface ZBQBNavigationVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *arrAllDate;
@property (nonatomic, strong)UITableViewCell *seleCell;
@property (nonatomic, assign)BOOL isToFenxi;

@end

@implementation ZBQBNavigationVC

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[ZBUMStatisticsMgr sharedInstance] viewStaticsBeginWithMarkStr:@"ZBQBNavigationVC"];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.defaultFailure = @"";

    [self setNavView];
    [self.view addSubview:self.tableView];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[ZBUMStatisticsMgr sharedInstance] viewStaticsEndWithMarkStr:@"ZBQBNavigationVC"];
}
#pragma mark -- setnavView
- (void)setNavView{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"比赛导航";
        [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
        [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"edit"] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(index == 2){
        
    }
}

#pragma mark ----------请求数据
- (void)loadData
{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    
    [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,@"/mobile/news/fullList"] Start:^(id requestOrignal) {
        [ZBLodingAnimateView showLodingView];
    } End:^(id responseOrignal) {
        [ZBLodingAnimateView dissMissLoadingView];
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSLog(@"%@",responseOrignal);
            _arrAllDate = [[NSMutableArray alloc] initWithArray:[ZBNavigationModel arrayOfEntitiesFromArray: [responseOrignal objectForKey:@"data"]]];
        self.defaultFailure = @"暂无数据";
            [self.tableView reloadData];
            
        }else{
            
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];
            [self.tableView reloadData];
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [self.tableView reloadData];
    }];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
//        [_tableView registerClass:[ZBNewQingBaoCell class] forCellReuseIdentifier:aCell];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        //        [self setupTableViewMJHeader];
    }
    return _tableView;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arrAllDate.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:aCell configuration:^(ZBNewQingBaoCell* cell) {
//        cell.model = _arrAllDate[indexPath.section];
//    }];
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aCell = @"acell";
    ZBQBNavigatCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell];
    if (!cell) {
        cell = [[ZBQBNavigatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aCell];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = _arrAllDate[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZBNavigationModel *model = _arrAllDate[indexPath.row];
    
    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)model.mid] toindex:2];
}
//跳转分析页
- (void)toFenxiWithMatchId:(NSString *)idID toindex:(NSInteger)index
{
    
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
    }else{
        return;
    }

    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parameter setObject:@"3" forKey:@"flag"];
    [parameter setObject:idID forKey:@"sid"];
    [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            ZBLiveScoreModel *model = [ZBLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            //从情报页跳转分析页的时候不用反转
            model.neutrality = NO;
            ZBFenxiPageVC *fenxiVC = [[ZBFenxiPageVC alloc] init];
            fenxiVC.model = model;
            fenxiVC.currentIndex = index;
            fenxiVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
            
        }
        _isToFenxi = NO;
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _isToFenxi = NO;
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
