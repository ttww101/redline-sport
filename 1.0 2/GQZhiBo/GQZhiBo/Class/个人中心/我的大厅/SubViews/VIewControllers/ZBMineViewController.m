#import "ZBMineViewController.h"
#import "ZBBasicTableView.h"
#import "ZBMineTableViewCell.h"
#import "ZBMineViewModel.h"
#import "ZBMineHeaderView.h"
#import "ZBUserTuijianVC.h"
#import "ZBMyBuyTuijianVC.h"
#import "ZBFeedbackVC.h"
#import "ZBSettingVC.h"
#import "ZBFriendsVC.h"
#import "ZBToolWebViewController.h"
#import "ZBToAnalystsVC.h"
@interface ZBMineViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) ZBBasicTableView *tableView;
@property (nonatomic, copy) NSArray *contentArray;
@property (nonatomic , strong) ZBMineHeaderView *headerView;
@property (nonatomic, strong) ZBUserModel *userModel;
@end
@implementation ZBMineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if ([ZBMethods login]) {
        self.headerView.height = 200 + 35;
    } else {
        self.headerView.height = 210;
    }
    [self loadData];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - Config UI
- (void)configUI {
    self.view.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.tabBarController.tabBar.height);
    adjustsScrollViewInsets_NO(self.tableView, self);
    [self setupHeader];
}
- (void)setupHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.stateLabel.font = font13;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}
#pragma mark - Load Data
- (void)loadData {
    _contentArray = [ZBMineViewModel getMineDataArray];
    if ([ZBMethods login]) {
        _userModel = [ZBMethods getUserModel];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
        [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userModel.idId] forKey:@"id"];
        [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_usernewinfo] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
            [self.tableView.mj_header endRefreshing];
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                _userModel = [ZBUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                [ZBMethods updateUsetModel:_userModel];
                self.headerView.model = _userModel;
                self.tableView.tableHeaderView = self.headerView;
                [self.tableView reloadData];
                if (_userModel == nil) {
                    self.headerView.height = 210;
                }
            }else{
                _userModel = [ZBMethods getUserModel];
                self.headerView.model = _userModel;
                self.tableView.tableHeaderView = self.headerView;
                [self.tableView reloadData];
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _userModel = [ZBMethods getUserModel];
            self.headerView.model = _userModel;
            self.tableView.tableHeaderView = self.headerView;
            [self.tableView reloadData];
        }];
        
        
        [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_minemessagecount] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                NSString *count = [responseOrignal objectForKey:@"data"];
                NSArray *array = _contentArray[2];
                ZBMineModel *model = array[0];
                model.numbers = count;
                NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:2];
                [self.tableView reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationFade];
            }else{
              
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            NSLog(@"11");
        }];
        
        
        
        
        
    } else {
        [self.tableView.mj_header endRefreshing];
        self.headerView.model = nil;
        self.tableView.tableHeaderView = self.headerView;
        if (_userModel == nil) {
            self.headerView.height = 210;
        }
        [self.tableView reloadData];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _contentArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arrar = _contentArray[section];
    return arrar.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *dataArray = _contentArray[indexPath.section];
    ZBMineTableViewCell *cell = [ZBMineTableViewCell cellForTableView:tableView];
    [cell refreshContentData:dataArray[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZBMineTableViewCell heightForCell];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumViewController *control = [[ForumViewController alloc]init];
    [self.navigationController pushViewController:control animated:true];
    return;
    switch (indexPath.section) {
        case 0:{
            if(![ZBMethods login]) {
                [ZBMethods toLogin];
                return;
            }
             if (indexPath.row == 0) {
                 [MobClick event:@"wdjc" label:@""];
                 ZBWebModel *model = [[ZBWebModel alloc]init];
                 model.title = @"账户明细";
                 model.webUrl = [NSString stringWithFormat:@"%@/%@/account-details.html", APPDELEGATE.url_ip,H5_Host];
                 ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
                 webDetailVC.model = model;
                 [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 1) {
                ZBWebModel *model = [[ZBWebModel alloc]init];
                model.title = @"购买记录";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/purchase-details.html?id=%zi", APPDELEGATE.url_ip,H5_Host,_userModel.idId];
                ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 2) {
                ZBWebModel *model = [[ZBWebModel alloc]init];
                model.title = @"分析师收入";
                model.hideNavigationBar = YES;
                model.webUrl = [NSString stringWithFormat:@"%@/%@/my-earnings.html", APPDELEGATE.url_ip,H5_Host];
                ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 3) {
                [MobClick event:@"yhq" label:@""];
                ZBWebModel *model = [[ZBWebModel alloc]init];
                model.title = @"优惠券";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/pay-card.html", APPDELEGATE.url_ip,H5_Host];
                ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                if(![ZBMethods login]) {
                    [ZBMethods toLogin];
                    return;
                }
                [[ZBDependetNetMethods sharedInstance] loadUserInfocompletion:^(ZBUserModel *userback) {
                    ZBUserModel *model = [ZBMethods getUserModel];
                    ZBToAnalystsVC *analysts = [[ZBToAnalystsVC alloc] init];
                    analysts.hidesBottomBarWhenPushed = YES;
                    analysts.type = model.analyst;
                    analysts.model = model;
                    [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
                } errorMessage:^(NSString *msg) {
                    ZBUserModel *model = [ZBMethods getUserModel];
                    ZBToAnalystsVC *analysts = [[ZBToAnalystsVC alloc] init];
                    analysts.hidesBottomBarWhenPushed = YES;
                    analysts.type = model.analyst;
                    analysts.model = model;
                    [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
                }];
                
            } else if (indexPath.row == 1) {
                if(![ZBMethods login]) {
                    [ZBMethods toLogin];
                    return;
                }
                ZBUserTuijianVC *tuijian = [[ZBUserTuijianVC alloc] init];
                tuijian.userName = self.userModel.nickname;
                tuijian.userId =  self.userModel.idId;
                tuijian.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:tuijian animated:YES];
               
            } else if (indexPath.row == 2) {
                if(![ZBMethods login]) {
                    [ZBMethods toLogin];
                    return;
                }
                ZBUserViewController *userVC = [[ZBUserViewController alloc] init];
                userVC.userId = _userModel.idId;
                userVC.hidesBottomBarWhenPushed = YES;
                userVC.Number=1;
                [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
            } else if (indexPath.row == 3) {
                ZBWebModel *model = [[ZBWebModel alloc]init];
                model.title = @"滚球服务";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/gunqiu-service.html", APPDELEGATE.url_ip,H5_Host];
                ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            }
        }
            break;
        case 2:{
            if (indexPath.row == 0) {
                if(![ZBMethods login]) {
                    [ZBMethods toLogin];
                    return;
                }
                ZBWebModel *model = [[ZBWebModel alloc]init];
                model.title = @"消息";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/message.html", APPDELEGATE.url_ip,H5_Host];
                ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
                model.hideNavigationBar = YES;
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 1) {
                [MobClick event:@"yqhy" label:@""];
                ZBWebModel *model = [[ZBWebModel alloc]init];
                model.title = @"邀请好友";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/invite-friends.html", APPDELEGATE.url_ip,H5_Host];
                ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 2) {
                ZBFeedbackVC *feed = [[ZBFeedbackVC alloc] init];
                feed.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:feed animated:YES];
            } else if (indexPath.row == 3) {
                ZBSettingVC *setVC = [[ZBSettingVC alloc] init];
                setVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:setVC animated:YES];
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark - Lazy Load
- (ZBBasicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[ZBBasicTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.defaultPage = defaultPageFirst;
        _tableView.defaultTitle = default_isLoading;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 10;
    }
    return _tableView;
}
- (ZBMineHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[ZBMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, Width, 210)];
    }
    return _headerView;
}
@end
