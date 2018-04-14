
//
//  LiveQuizWithDrawalViewController.m
//  newGQapp
//
//  Created by genglei on 2018/4/13.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "LiveQuizWithDrawalViewController.h"
#import "WithdrawalView.h"
#import <YYModel/YYModel.h>

@interface LiveQuizWithDrawalViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) BasicTableView *tableView;

@property (nonatomic , strong) WithdrawaListModel *listModel;

@property (nonatomic , strong) WithdrawalView *withdradalView;



@end

@implementation LiveQuizWithDrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Config UI

- (void)configUI {
    [self.navigationController setNavigationBarHidden:false animated:YES];
    self.navigationItem.title = @"提现";
    self.view.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    adjustsScrollViewInsets_NO(self.tableView, self);
    self.tableView.tableHeaderView = self.withdradalView;
}

#pragma mark - Load Data

- (void)loadData {
    [LodingAnimateView showLodingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    [parameter setObject:@"0" forKey:@"limitStart"];
    [parameter setObject:@"20" forKey:@"limitNum"];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_reward_list]  Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            _listModel = [WithdrawaListModel yy_modelWithDictionary:responseOrignal[@"data"]];
            [self.withdradalView setcontentWithData:_listModel];
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:responseResult];
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveQuizWithdrawalTableViewCell *cell = [LiveQuizWithdrawalTableViewCell cellForTableView:tableView];
    [cell refreshContentData:_listModel.items[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [LiveQuizWithdrawalTableViewCell heightForCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


#pragma mark - Lazy Load

- (BasicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BasicTableView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.defaultPage = defaultPageFirst;
        _tableView.defaultTitle = default_isLoading;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
}

- (WithdrawalView *)withdradalView {
    if (_withdradalView == nil) {
        _withdradalView = [[WithdrawalView alloc]init];
    }
    return _withdradalView;
}


@end
