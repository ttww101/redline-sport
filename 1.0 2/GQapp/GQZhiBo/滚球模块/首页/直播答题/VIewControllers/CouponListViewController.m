//
//  CouponListViewController.m
//  newGQapp
//
//  Created by genglei on 2018/4/13.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "CouponListViewController.h"
#import "CouponListTableViewCell.h"
#import "CouponModel.h"
#import <YYModel/YYModel.h>

@interface CouponListViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) BasicTableView *tableView;

@property (nonatomic , strong) CouponListModel *listModel;


@end

@implementation CouponListViewController

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
    self.navigationItem.title = @"我的优惠券";
    self.view.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    adjustsScrollViewInsets_NO(self.tableView, self);
}

#pragma mark - Load Data

- (void)loadData {
    [LodingAnimateView showLodingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_couponlist]  Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
             _listModel = [CouponListModel yy_modelWithDictionary:responseOrignal];
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
    return _listModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponListTableViewCell *cell = [CouponListTableViewCell cellForTableView:tableView];
    [cell refreshContentData:_listModel.data[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CouponListTableViewCell heightForCell];
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


@end
