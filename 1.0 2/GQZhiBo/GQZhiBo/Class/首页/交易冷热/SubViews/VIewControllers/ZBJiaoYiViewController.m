#import "ZBJiaoYiViewController.h"
#import "ZBTitleIndexView.h"
#import "ZBPageScrollView.h"
#import "ZBJiaoYiNewTabelView.h"
#import "ZBJiaoYiModel.h"
@interface ZBJiaoYiViewController ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) ZBPageScrollView *scrollView;
@property (nonatomic, strong) ZBTitleIndexView *titleView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, retain) ZBJiaoYiNewTabelView *tableView1;
@property (nonatomic, retain) ZBJiaoYiNewTabelView *tableView2;
@property (nonatomic, retain) ZBJiaoYiNewTabelView *tableView3;
@end
@implementation ZBJiaoYiViewController
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
    [self setNavView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _selectedIndex = 0;
    _titleView = [[ZBTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.nalColor = colorFFD8D6;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.backgroundColor = redcolor;
    _titleView.arrData = @[@"总交易量",@"机构盈利",@"机构亏损"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    _scrollView = [[ZBPageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = 0;
    [self.view addSubview:_scrollView];
    [_scrollView reloadData];
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    [_scrollView updateSelectedIndex:index];
}
- (void)scrollToPageIndex:(NSInteger)index
{
    [_titleView updateSelectedIndex:index];
}
- (ZBJiaoYiNewTabelView *)tableView1
{
    if (!_tableView1) {
        _tableView1 = [[ZBJiaoYiNewTabelView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    }
    return _tableView1;
}
- (ZBJiaoYiNewTabelView *)tableView2
{
    if (!_tableView2) {
        _tableView2 = [[ZBJiaoYiNewTabelView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    }
    return _tableView2;
}
- (ZBJiaoYiNewTabelView *)tableView3
{
    if (!_tableView3) {
        _tableView3 = [[ZBJiaoYiNewTabelView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    }
    return _tableView3;
}
- (UITableView *)pageScrollView:(ZBPageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    if (index== 0) {
        [self.tableView1 updateWithType:3];
        return self.tableView1;
    }else if(index == 1){
        [self.tableView2 updateWithType:1];
        return self.tableView2;
    }else{
        [self.tableView3 updateWithType:2];
        return self.tableView3;
    }
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(ZBPageScrollView *)pageScroll
{
    return 3;
}
- (void)setNavView{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"交易冷热";
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
