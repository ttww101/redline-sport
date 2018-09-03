#import "ZBTongpeiTongjiVC.h"
#import "ZBTitleIndexView.h"
#import "ZBPageScrollView.h"
#import "ZBTongPeiTongjiTable.h"
#import "ZBTongPeiTJModel.h"
@interface ZBTongpeiTongjiVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) ZBPageScrollView *scrollView;
@property (nonatomic, strong) ZBTitleIndexView *titleView;
@end
@implementation ZBTongpeiTongjiVC
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
    self.defaultFailure = @"";
    [self setNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[ZBTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.backgroundColor = redcolor;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.nalColor = colorFFD8D6;
    _titleView.arrData = @[@"胜平负",@"亚盘",@"大小球",];
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
    if (index== 1) {
        ZBTongPeiTongjiTable *table = [[ZBTongPeiTongjiTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.defaultTitle = self.defaultFailure;
        [table updateWithType:1];
        return table;
    }else if (index== 2){
        ZBTongPeiTongjiTable *table = [[ZBTongPeiTongjiTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.defaultTitle = self.defaultFailure;
        [table updateWithType:2];
        return table;
    }else if (index== 0){
        ZBTongPeiTongjiTable *table = [[ZBTongPeiTongjiTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.defaultTitle = self.defaultFailure;
        [table updateWithType:0];
        return table;
    }else{
        return [UITableView new];
    }
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(ZBPageScrollView *)pageScroll
{
    return 3;
}
#pragma mark -- setnavView
- (void)setNavView
{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"同赔指数";
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
