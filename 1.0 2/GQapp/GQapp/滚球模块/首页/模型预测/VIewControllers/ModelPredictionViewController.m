//
//  ModelPredictionViewController.m
//  newGQapp
//
//  Created by genglei on 2018/3/30.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ModelPredictionViewController.h"
#import "UniversaListCell.h"
#import "ModelPredictionViewModel.h"
#import "NullTableViewCell.h"

@interface ModelPredictionViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) BasicTableView *tableView;

@property (nonatomic, copy) NSArray *contentArray;


@end

@implementation ModelPredictionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationItem.title = @"模型预测";
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
    _contentArray = [ModelPredictionViewModel createModelListArray];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _contentArray.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        NullTableViewCell *nullCell = [NullTableViewCell cellForTableView:tableView];
        return nullCell;
    } else {
        UniversaListCell *cell = [UniversaListCell cellForTableView:tableView];
        [cell refreshContentData:_contentArray[indexPath.row / 2]];
        return cell;
    }
  
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return [NullTableViewCell heightForCell];
    } else {
       return [UniversaListCell heightForCell];
    }
    
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
