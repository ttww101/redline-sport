#import "ZBLiveListViewController.h"
#import "ZBMatchListViewModel.h"
#import "ZBLiveListTableViewCell.h"
#import "ZBToolWebViewController.h"
@interface ZBLiveListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZBMatchListViewModel *matchListViewModel;
@property (nonatomic , strong) LiveListArrayModel *listModel;
@end
@implementation ZBLiveListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
    [self setupHeaderView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Config UI
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)setupHeaderView {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = font13;
    self.tableView.mj_header = header;
}
#pragma mark - Load Data
- (void)loadData {
    [self.matchListViewModel fetchMatchDateInterfaceWithParameter:_dayID callBack:^(BOOL isSuccess, id response) {
        [self.tableView.mj_header endRefreshing];
        if (isSuccess) {
            self.listModel = response;
            if (self.listModel.data.count > 0) {
                [self.tableView reloadData];
            } else {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂无内容"];
            }
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:response];
        }
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listModel.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZBLiveListModel *liveListModel = self.listModel.data[indexPath.row];
    ZBLiveListTableViewCell *cell = [ZBLiveListTableViewCell cellForTableView:tableView];
    [cell refreshContentData:liveListModel];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZBLiveListTableViewCell heightForCell];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZBLiveListModel *contentModel =self.listModel.data[indexPath.row];
    ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
    webDetailVC.webTitle = @"直播";
    webDetailVC.urlPath = [NSString stringWithFormat:@"http://api.live.gunqiu.com:88/radarpage/%@.html",contentModel.mid];
    [self.navigationController pushViewController:webDetailVC animated:YES];
}
#pragma mark - Lazy Load
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}
- (ZBMatchListViewModel *)matchListViewModel {
    if (_matchListViewModel == nil) {
        _matchListViewModel = [[ZBMatchListViewModel alloc]init];
    }
    return _matchListViewModel;
}
@end
