//
//  GQMineViewController.m
//  newGQapp
//
//  Created by genglei on 2018/4/27.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "GQMineViewController.h"
#import "BasicTableView.h"
#import "GQMineTableViewCell.h"
#import "GQMineViewModel.h"
#import "GQMineHeaderView.h"
#import "UserTuijianVC.h"
#import "MyBuyTuijianVC.h"
#import "FeedbackVC.h"
#import "SettingVC.h"
#import "FriendsVC.h"
#import "ToolWebViewController.h"

@interface GQMineViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) BasicTableView *tableView;

@property (nonatomic, copy) NSArray *contentArray;

@property (nonatomic , strong) GQMineHeaderView *headerView;

@property (nonatomic, strong) UserModel *userModel;



@end

@implementation GQMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if ([Methods login]) {
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
    _contentArray = [GQMineViewModel getMineDataArray];
    if ([Methods login]) {
        _userModel = [Methods getUserModel];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
        [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userModel.idId] forKey:@"id"];
        
        [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_usernewinfo] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            [self.tableView.mj_header endRefreshing];
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                _userModel = [UserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                [Methods updateUsetModel:_userModel];
                self.headerView.model = _userModel;
                self.tableView.tableHeaderView = self.headerView;
                [self.tableView reloadData];
                if (_userModel == nil) {
                    self.headerView.height = 210;
                }
            }else{
                _userModel = [Methods getUserModel];
                self.headerView.model = _userModel;
                self.tableView.tableHeaderView = self.headerView;
                [self.tableView reloadData];
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _userModel = [Methods getUserModel];
            self.headerView.model = _userModel;
            self.tableView.tableHeaderView = self.headerView;
            [self.tableView reloadData];
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
    GQMineTableViewCell *cell = [GQMineTableViewCell cellForTableView:tableView];
    [cell refreshContentData:dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GQMineTableViewCell heightForCell];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            if(![Methods login]) {
                [Methods toLogin];
                return;
            }
             if (indexPath.row == 0) {
                 [MobClick event:@"wdjc" label:@""];
                 WebModel *model = [[WebModel alloc]init];
                 model.title = @"我的竞猜";
                 model.webUrl = [NSString stringWithFormat:@"%@/goto/jingcai", APPDELEGATE.url_jsonHeader];
                 ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
                 webDetailVC.model = model;
                 [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 1) {
                WebModel *model = [[WebModel alloc]init];
                model.title = @"账户明细";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/account-details.html", APPDELEGATE.url_ip,H5_Host];
                ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 2) {
                WebModel *model = [[WebModel alloc]init];
                model.title = @"购买记录";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/purchase-details.html?id=%zi", APPDELEGATE.url_ip,H5_Host,_userModel.idId];
                ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            }
        }
            break;
            
        case 1:{
            if (indexPath.row == 0) {
                if(![Methods login]) {
                    
                    [Methods toLogin];
                    return;
                }
                WebModel *model = [[WebModel alloc]init];
                model.title = @"分析师收入";
                model.hideNavigationBar = YES;
                model.webUrl = [NSString stringWithFormat:@"%@/%@/my-earnings.html", APPDELEGATE.url_ip,H5_Host];
                ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
                
            } else if (indexPath.row == 1) {
                if(![Methods login]) {
                    
                    [Methods toLogin];
                    return;
                }
                [MobClick event:@"yhq" label:@""];
                WebModel *model = [[WebModel alloc]init];
                model.title = @"优惠券";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/pay-card.html", APPDELEGATE.url_ip,H5_Host];
                ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 2) {
                if(![Methods login]) {
                    
                    [Methods toLogin];
                    return;
                }
                UserViewController *userVC = [[UserViewController alloc] init];
                userVC.userId = _userModel.idId;
                userVC.hidesBottomBarWhenPushed = YES;
                userVC.Number=1;
                [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
            } else if (indexPath.row == 3) {
                WebModel *model = [[WebModel alloc]init];
                model.title = @"滚球服务";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/gunqiu-service.html", APPDELEGATE.url_ip,H5_Host];
                ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            }
        }
            break;
//
//        case 2:{
//            if(![Methods login]) {
//
//                [Methods toLogin];
//                return;
//            }
//            if (indexPath.row == 0) {
//                // 关注
//                FriendsVC *friend = [[FriendsVC alloc] init];
//                friend.userId = _userModel.idId;
//                friend.selectedIndex = 0;
//                friend.hidesBottomBarWhenPushed = YES;
//                [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
//            } else if (indexPath.row == 1) {
//                // 粉丝
//                FriendsVC *friend = [[FriendsVC alloc] init];
//                friend.userId = _userModel.idId;
//                friend.selectedIndex = 1;
//                friend.hidesBottomBarWhenPushed = YES;
//                [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
//            }
//        }
//            break;
            
        case 2:{
            if (indexPath.row == 0) {
                [MobClick event:@"yqhy" label:@""];
                WebModel *model = [[WebModel alloc]init];
                model.title = @"邀请好友";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/invite-friends.html", APPDELEGATE.url_ip,H5_Host];
                ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 1) {
                //                反馈
                FeedbackVC *feed = [[FeedbackVC alloc] init];
                feed.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:feed animated:YES];
            } else if (indexPath.row == 2) {
//                更所选项
                SettingVC *setVC = [[SettingVC alloc] init];
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

- (BasicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BasicTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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

- (GQMineHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[GQMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, Width, 210)];
    }
    return _headerView;
}

@end
