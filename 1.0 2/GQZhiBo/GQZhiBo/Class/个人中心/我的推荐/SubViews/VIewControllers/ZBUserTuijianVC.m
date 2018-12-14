#import "ZBUserTuijianVC.h"
#import "ZBTitleIndexView.h"
#import "ZBPageScrollView.h"
#import "ZBUserTuijianTable.h"
@interface ZBUserTuijianVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) ZBPageScrollView *scrollView;
@property (nonatomic, strong) ZBTitleIndexView *titleView;
@end
@implementation ZBUserTuijianVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[ZBTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.arrData = @[@"全部",@"胜平负",@"亚指",@"进球数"];
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
- (UITableView *)pageScrollView:(ZBPageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    ZBUserTuijianTable *table = [[ZBUserTuijianTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.userId = _userId;
    table.oddtype = index;
    [table loadNewData];
    return table;
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(ZBPageScrollView *)pageScroll
{
    return 4;
}
#pragma mark -- setnavView
- (void)setNavView
{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    ZBUserModel *user = [ZBMethods getUserModel];
    if (user.idId == _userId) {
        nav.labTitle.text = @"推荐记录" ;
    }else{
        nav.labTitle.text = [NSString stringWithFormat:@"%@的推荐",_userName] ;
    }
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
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
