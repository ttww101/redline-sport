//
//  LiveListViewController.m
//  newGQapp
//
//  Created by genglei on 2018/4/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "LiveListViewController.h"
#import "MatchListViewModel.h"
#import "LiveListTableViewCell.h"

@interface LiveListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MatchListViewModel *matchListViewModel;

@property (nonatomic , strong) LiveListArrayModel *listModel;

@end

@implementation LiveListViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - Load Data

- (void)loadData {
    [self.matchListViewModel fetchMatchDateInterfaceWithParameter:_dayID callBack:^(BOOL isSuccess, id response) {
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
    LiveListModel *liveListModel = self.listModel.data[indexPath.row];
    LiveListTableViewCell *cell = [LiveListTableViewCell cellForTableView:tableView];
    [cell refreshContentData:liveListModel];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [LiveListTableViewCell heightForCell];
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

- (MatchListViewModel *)matchListViewModel {
    if (_matchListViewModel == nil) {
        _matchListViewModel = [[MatchListViewModel alloc]init];
    }
    return _matchListViewModel;
}

@end
