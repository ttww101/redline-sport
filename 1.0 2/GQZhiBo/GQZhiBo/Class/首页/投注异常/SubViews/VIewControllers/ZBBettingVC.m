#import "ZBBettingVC.h"
#import "ZBBettingCell.h"
#import "ZBTouZhuModel.h"
#import "ZBFenxiPageVC.h"
#import "ZBTitleIndexView.h"
#import "ZBPageScrollView.h"
#import "ZBBetTingTableView.h"
@interface ZBBettingVC ()<TitleIndexViewDelegate,PageScrollViewDateSource,PageScrollViewDelegate>
@property (nonatomic, retain)NSMutableArray *arrDataOne;
@property (nonatomic, retain)NSMutableArray *arrDataTwo;
@property (nonatomic, retain)NSMutableArray *arrDataThree;
@property (nonatomic, retain)NSMutableArray *arrDataFive;
@property (nonatomic, retain)NSMutableArray *arrAllData;
@property (nonatomic, strong)ZBBettingCell *seleCell;
@property (nonatomic, strong) ZBTitleIndexView *titleView;
@property (nonatomic, strong) ZBPageScrollView *scrollView;
@property (nonatomic, assign)NSInteger selectedIndex;
@property (nonatomic, strong)ZBBetTingTableView *tableViewOne;
@end
@implementation ZBBettingVC
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
    _titleView = [[ZBTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.nalColor = colorFFD8D6;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.backgroundColor = redcolor;
    _titleView.arrData = @[@"全部",@"主胜",@"平局",@"客胜"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    _scrollView = [[ZBPageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = 0;
    [self.view addSubview:_scrollView];
    [_scrollView reloadData];
    [self getData];
}
- (void)getData{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parameter setObject:@(1) forKey:@"flag"];
    [parameter setObject:@(4) forKey:@"type"];
    [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_JiaoYiList] Start:^(id requestOrignal) {
        [self.tableViewOne.mj_header beginRefreshing];
    } End:^(id responseOrignal) {
        [self.tableViewOne.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] intValue] == 200) {
        self.arrAllData = [[NSMutableArray alloc] initWithArray:[ZBTouZhuModel arrayOfEntitiesFromArray:responseOrignal[@"data"]]];
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
        ZBTouZhuModel *model = self.arrAllData[i];
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
- (UITableView *)pageScrollView:(ZBPageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    if (index== 0) {
        _tableViewOne = [[ZBBetTingTableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        _tableViewOne.arrData = self.arrDataOne;
        return _tableViewOne;
    }else if(index == 1){
        ZBBetTingTableView *tableView = [[ZBBetTingTableView alloc] initWithFrame:CGRectMake(Width, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        tableView.arrData = self.arrDataTwo;
        return tableView;
    }else if(index == 2){
        ZBBetTingTableView *tableView = [[ZBBetTingTableView alloc] initWithFrame:CGRectMake(Width * 2, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        tableView.arrData = self.arrDataThree;
        return tableView;
    }else{
        ZBBetTingTableView *tableView = [[ZBBetTingTableView alloc] initWithFrame:CGRectMake(Width * 3, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        tableView.arrData = self.arrDataFive;
        return tableView;
    }
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(ZBPageScrollView *)pageScroll
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
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"投注异常";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
