//
//  NewRecommandVC.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/4/27.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "NewRecommandVC.h"
#import "TitleIndexView.h"
#import "PageScrollView.h"
#import "BangDanTableView.h"
#import "RecommandListModel.h"
@interface NewRecommandVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>

@property (nonatomic, strong) PageScrollView *scrollView;
@property (nonatomic, strong) TitleIndexView *titleView;

@property (nonatomic, strong)BangDanTableView *tableView;
@property (nonatomic, strong)BangDanTableView *tableViewWeek;//周榜
@property (nonatomic, strong)BangDanTableView *tableViewMon;//月榜
@property (nonatomic, strong)BangDanTableView *tableViewAll;//总榜




//列表数组
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrDataTwo;
@property (nonatomic, strong) NSArray *arrDataThree;
@property (nonatomic, strong) NSArray *arrDataFour;


@property (nonatomic, assign) NSInteger ListItemWeek;//周榜
@property (nonatomic, assign)BOOL yesORno;


@end

@implementation NewRecommandVC
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
    [self setNavView];
    _yesORno = NO;
    [LodingAnimateView showLodingView];
    if(self.typeList == typeListOne){
        _ListItemWeek = 0;
        
        for (int i = 0; i < 4; i ++) {
            [self setNumGetData:i];
        
        }
    }else{
        [self setNumGetDataTwo];
    }

    

    // Do any additional setup after loading the view.
}
- (void)setNumGetData:(NSInteger)num{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
//    NSString *ranktype = @"1";
    NSString *urlStr = url_rankingquery;
//    NSString *datestr;
    switch (num) {
        case 0:
        {
            
            
            
            [parameter setObject:@"1" forKey:@"type"];
            [parameter setObject:@"1" forKey:@"ranktype"];
            

        }
            break;
        case 1:
        {
//            周
            [parameter setObject:@"1" forKey:@"type"];
            [parameter setObject:@"1" forKey:@"ranktype"];
            
            urlStr = url_rankingqueryWM;//这里设置url
        }
            break;
        case 2:
        {
            [parameter setObject:@"2" forKey:@"type"];
            [parameter setObject:@"1" forKey:@"ranktype"];
            
            urlStr = url_rankingqueryWM;//这里设置url
        }
            break;
        case 3:
        {
            
            
            
            [parameter setObject:@"3" forKey:@"type"];
            [parameter setObject:@"1" forKey:@"ranktype"];

        }
            break;
            
        default:
            break;
    }
    
    [self loadDataRecommandListParameter:parameter urlStr:urlStr num:num];
    
}
- (void)setNumGetDataTwo{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
//    NSString *ranktype;
    NSString *urlStr = @"";
    if (self.typeList == typeListTwo){//人气榜
        
        [parameter setObject:@"3" forKey:@"type"];
        [parameter setObject:@"2" forKey:@"ranktype"];

    }else if (self.typeList == typeListFore){
//        连红
        [parameter setObject:@"3" forKey:@"type"];
        [parameter setObject:@"3" forKey:@"ranktype"];

    }else if (self.typeList == typeListThree){//明灯榜
        
//        ranktype = @"4";//；连黑榜
//        [parameter setObject:@"3" forKey:@"type"];

    }else if (self.typeList == typeListFive){
//        盈利榜
        [parameter setObject:@"4" forKey:@"type"];
        [parameter setObject:@"1" forKey:@"ranktype"];
    }
//    [parameter setObject:@"0" forKey:@"play"];
//    [parameter setObject:@"-1" forKey:@"sclassid"];
//    [parameter setObject:ranktype forKey:@"ranktype"];
//    [parameter setObject:@"-1" forKey:@"datestr"];
    urlStr = url_rankingquery;
//    [parameter setObject:@"3" forKey:@"type"];
    [self loadDataRecommandListParameter:parameter urlStr:urlStr num:0];
    
    
}



#pragma mark -- setnavView
- (void)setNavView{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = self.titleStr;
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"tuijianDTLeftImage"] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"tuijianDTLeftImage"] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
    
    
    //设置滚动的view
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 50)];
    _titleView.selectedIndex = 0;
    _titleView.arrData = @[@"近7天",@"周榜",@"月榜",@"总榜",];
    _titleView.delegate =self;
    
    if (self.typeList == typeListOne) {
        [self.view addSubview:_titleView];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.bottom-1, Width, 0.5)];
        lineView.backgroundColor = colorCellLine;
        [self.view addSubview:lineView];
        _scrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
        
    }else{
        _scrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
    }

    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = 0;
    [self.view addSubview:_scrollView];
//    [self loadDataRecommandList];
   
}
- (void)loadDataRecommandListParameter:(NSMutableDictionary *)parameterDic urlStr:(NSString *)url num:(NSInteger)num
{

    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameterDic PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url] Start:^(id requestOrignal) {
        if (self.typeList == typeListOne && !_yesORno) {
            _yesORno = YES;
            if (_ListItemWeek == 0) {
                
            }
        }else if (self.typeList != typeListOne){
//            [LodingAnimateView showLodingView];
        }
        
    } End:^(id responseOrignal) {
        if (self.typeList == typeListOne){
            if (num == 2) {
                [LodingAnimateView dissMissLoadingView];
            }
            
        }else{
            [LodingAnimateView dissMissLoadingView];
        }
        

    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            self.defaultFailure = @"";
            if (self.typeList == typeListOne) {
                switch (num) {
                    case 0:{
                        _arrData = [[NSArray alloc] initWithArray:[RecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                        self.defaultFailure = @"暂无数据";

                        NSLog(@"%@",responseOrignal);
                    }
                        break;
                    case 1:{
                        _arrDataTwo = [[NSArray alloc] initWithArray:[RecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                    }
                        break;
                    case 2:{
                        _arrDataThree = [[NSArray alloc] initWithArray:[RecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                        
                    }
                        break;
                    case 3:{
                        _arrDataFour = [[NSArray alloc] initWithArray:[RecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                        
                         [LodingAnimateView dissMissLoadingView];
                    }
                        break;
                        
                    default:
                        break;
                }
                [_scrollView reloadData];
                
            }else{
                self.defaultFailure = @"暂无数据";

                _arrData = [[NSArray alloc] initWithArray:[RecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                [_scrollView reloadData];
            }
            
        }else{

            
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
    }];
}

- (void)didSelectedAtIndex:(NSInteger)index
{
    _ListItemWeek = index;
    [_scrollView updateSelectedIndex:index];
//    [self loadDataRecommandList];
}
- (void)scrollToPageIndex:(NSInteger)index
{
    _ListItemWeek = index;
    [_titleView updateSelectedIndex:index];
//    [self loadDataRecommandList];
}
- (UITableView *)pageScrollView:(PageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    _tableView = [[BangDanTableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    [self createHeard:_tableView];
    if (self.typeList == typeListOne) {
        switch (index) {
            case 0:{
                _tableView.defaultTitle = self.defaultFailure;
                _tableView.labStr = @"盈利率";
                _tableView.labStrTwo = @"胜率";
                _tableView.typeNum = self.typeList;
                _tableView.arrData = _arrData;
                return _tableView;
            }
                break;
            case 1:{
                _tableViewWeek = [[BangDanTableView alloc] initWithFrame:CGRectMake(Width * 1, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
                [self createHeard:_tableViewWeek];
                _tableViewWeek.defaultTitle = self.defaultFailure;

                _tableViewWeek.labStr = @"盈利率";
                _tableViewWeek.labStrTwo = @"胜率";
                _tableViewWeek.typeNum = self.typeList;
                _tableViewWeek.arrData = _arrDataTwo;
                return _tableViewWeek;
            }
                break;
            case 2:{
                _tableViewMon = [[BangDanTableView alloc] initWithFrame:CGRectMake(Width * 2, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
                [self createHeard:_tableViewMon];
                _tableViewMon.defaultTitle = self.defaultFailure;

                _tableViewMon.labStr = @"盈利率";
                _tableViewMon.labStrTwo = @"胜率";
                _tableViewMon.typeNum = self.typeList;
                _tableViewMon.arrData = _arrDataThree;
                return _tableViewMon;
            }
                break;
            case 3:{
                _tableViewAll = [[BangDanTableView alloc] initWithFrame:CGRectMake(Width * 3, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
                [self createHeard:_tableViewAll];
                _tableViewAll.defaultTitle = self.defaultFailure;

                _tableViewAll.labStr = @"盈利率";
                _tableViewAll.labStrTwo = @"胜率";
                _tableViewAll.typeNum = self.typeList;

                _tableViewAll.arrData = _arrDataFour;
                return _tableViewAll;
            }
                break;
                
            default:
                break;
        }
        
    }else if (self.typeList == typeListFore){
        _tableView.defaultTitle = self.defaultFailure;

        _tableView.labStr = @"最长连红";
        _tableView.labStrTwo = @"最近连红";
        _tableView.typeNum = self.typeList;
        _tableView.arrData = _arrData;
    }else if ( self.typeList == typeListThree){
        _tableView.defaultTitle = self.defaultFailure;

        _tableView.labStr = @"最长连黑";
        _tableView.labStrTwo = @"最近连黑";
        _tableView.typeNum = self.typeList;
        _tableView.arrData = _arrData;
    }else if (self.typeList == typeListFive){
        _tableView.defaultTitle = self.defaultFailure;

        _tableView.labStr = @"总盈利率";
        _tableView.labStrTwo = @"总盈利";
        _tableView.typeNum = self.typeList;
        _tableView.arrData = _arrData;
    }
    else{
        _tableView.defaultTitle = self.defaultFailure;

        _tableView.labStr = @"粉丝数";
        _tableView.labStrTwo = @"";
        _tableView.typeNum = self.typeList;
        _tableView.arrData = _arrData;
    }
    
    return _tableView;
}
- (void)createHeard:(UITableView *)tabel{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataByHeader)];
    header.stateLabel.font = font13;
    header.lastUpdatedTimeLabel.hidden = YES;
    tabel.mj_header = header;
    
}
#pragma mark ---- 下啦刷新
- (void)refreshDataByHeader{
    if(self.typeList == typeListOne){
        [self setNumGetData:_ListItemWeek];
        
    }else{
        [self setNumGetDataTwo];
    }
    
    
    
}

- (NSInteger)numberOfIndexInPageSrollView:(PageScrollView *)pageScroll
{
    if (self.typeList == typeListOne) {
        return 4;
    }
    return 1;
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(index == 2){
        WebVC *webV = [[WebVC alloc] init];
        webV.strtitle = @"排行榜规则";
        //webV.strurl = [NSString stringWithFormat:@"%@/help/v1.8.0/phb.html",APPDELEGATE.url_ServerWWW] ;
        webV.strurl=BANGDAN_API_HTML;
        webV.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:webV animated:YES];
        
//        BangdanRulesVC *ruleVC =  [[BangdanRulesVC alloc] init];
//        ruleVC.hidesBottomBarWhenPushed = YES;
//        [APPDELEGATE.customTabbar pushToViewController:ruleVC animated:YES];
        
    }
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
