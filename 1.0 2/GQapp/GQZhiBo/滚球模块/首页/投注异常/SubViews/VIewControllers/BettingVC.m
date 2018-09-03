//
//  BettingVC.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/20.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BettingVC.h"
#import "BettingCell.h"

#import "TouZhuModel.h"
//#import "LiveScoreModel.h"
#import "FenxiPageVC.h"
#import "TitleIndexView.h"
#import "PageScrollView.h"
#import "BetTingTableView.h"

@interface BettingVC ()<TitleIndexViewDelegate,PageScrollViewDateSource,PageScrollViewDelegate>

@property (nonatomic, retain)NSMutableArray *arrDataOne;
@property (nonatomic, retain)NSMutableArray *arrDataTwo;
@property (nonatomic, retain)NSMutableArray *arrDataThree;
@property (nonatomic, retain)NSMutableArray *arrDataFive;

@property (nonatomic, retain)NSMutableArray *arrAllData;

//分享
@property (nonatomic, strong)BettingCell *seleCell;
@property (nonatomic, strong) TitleIndexView *titleView;
@property (nonatomic, strong) PageScrollView *scrollView;

@property (nonatomic, assign)NSInteger selectedIndex;

@property (nonatomic, strong)BetTingTableView *tableViewOne;

@end

@implementation BettingVC
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}

-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    _selectedIndex = 0;
    _titleView = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    //    _titleView.bottomLineColor = [UIColor whiteColor];
    _titleView.nalColor = colorFFD8D6;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.backgroundColor = redcolor;
    _titleView.arrData = @[@"全部",@"主胜",@"平局",@"客胜"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    
    
    _scrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = 0;
    [self.view addSubview:_scrollView];
    [_scrollView reloadData];
   
    [self getData];
//    }
    
    // Do any additional setup after loading the view.
}

- (void)getData{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@(1) forKey:@"flag"];
    [parameter setObject:@(4) forKey:@"type"];
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_JiaoYiList] Start:^(id requestOrignal) {
        [self.tableViewOne.mj_header beginRefreshing];
    } End:^(id responseOrignal) {
        [self.tableViewOne.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
//        NSLog(@"%@",responseOrignal);
//        self.arrData = [[NSMutableArray alloc] initWithArray:[TouZhuModel arrayOfEntitiesFromArray:responseOrignal[@"data"]]];
        
        if ([[responseOrignal objectForKey:@"code"] intValue] == 200) {

        
        self.arrAllData = [[NSMutableArray alloc] initWithArray:[TouZhuModel arrayOfEntitiesFromArray:responseOrignal[@"data"]]];
        
//        [CacheObject storage_Memory_UrlKey:@"touzhu" data:responseOrignal[@"data"] hour:5];//缓存数据
        [self setDataToArr];
            
        }else{
            
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
                
            
        }

    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];

        
    }];
}
- (void)setDataToArr{
    _arrDataOne = [[NSMutableArray alloc] initWithCapacity:0];
    _arrDataTwo = [[NSMutableArray alloc] initWithCapacity:0];
    _arrDataThree = [[NSMutableArray alloc] initWithCapacity:0];
    _arrDataFive = [[NSMutableArray alloc] initWithCapacity:0];
    self.arrDataOne = self.arrAllData;
    for (int i = 0; i < self.arrAllData.count;  i ++) {
        
        TouZhuModel *model = self.arrAllData[i];
        
        switch ([model.deal[@"type"] integerValue]) {
                break;
            case 1:{
                
                
                    [self.arrDataThree addObject:model];
                
            }
                break;
                
            case 0:{
                
                    [self.arrDataFive addObject:model];
                
            }
                break;
                
            case 3:{
                
               
                    [self.arrDataTwo addObject:model];
                
            }
                break;
                
                
            default:
                break;
        }
        
    }
    [_scrollView reloadData];
    
}
- (UITableView *)pageScrollView:(PageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    if (index== 0) {
        
        _tableViewOne = [[BetTingTableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        _tableViewOne.arrData = self.arrDataOne;
        
        return _tableViewOne;
        
    }else if(index == 1){
        
        
        BetTingTableView *tableView = [[BetTingTableView alloc] initWithFrame:CGRectMake(Width, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        tableView.arrData = self.arrDataTwo;
        
        return tableView;
        
    }else if(index == 2){
        
        BetTingTableView *tableView = [[BetTingTableView alloc] initWithFrame:CGRectMake(Width * 2, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        tableView.arrData = self.arrDataThree;
        
        return tableView;
    }else{
        BetTingTableView *tableView = [[BetTingTableView alloc] initWithFrame:CGRectMake(Width * 3, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        tableView.arrData = self.arrDataFive;
        
        return tableView;
    }
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(PageScrollView *)pageScroll
{
    return 4;
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    _selectedIndex = index;
    [_scrollView updateSelectedIndex:index];
}
- (void)scrollToPageIndex:(NSInteger)index
{
    [_titleView updateSelectedIndex:index];
    _selectedIndex = index;
}



- (void)setNavView{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"投注异常";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"shareWhite"] forState:UIControlStateNormal];
//    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"shareWhite"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:nav];
    
}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(index == 2){
//        NSLog(@"%@",[NSString stringWithFormat:@"%@/share/v5.0/yichang.html?type=%ld",APPDELEGATE.url_jsonHeader,_selectedIndex]);
        
//        if (![Methods login]) {
//            [Methods toLogin];
//            return;
//        }
//            _shareViews = [[ShareView alloc] initWithViewController:self];
//            _shareViews.shareWebUrl = [NSString stringWithFormat:@"%@%@yichang.html?type=%ld",APPDELEGATE.url_jsonHeader,url_share,_selectedIndex];
//            _shareViews.shareImageUrl = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_jsonHeader,url_shareImage(@"applogo")];
//            _shareViews.shareTitle = @"投注异常【滚球体育】";
//            _shareViews.shareContent = @"更多数据、情报、推荐资讯请下载滚球体育";
//            [_shareViews shareViewShow];
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
