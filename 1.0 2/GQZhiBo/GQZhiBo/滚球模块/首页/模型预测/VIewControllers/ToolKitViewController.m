//
//  ToolKitViewController.m
//  newGQapp
//
//  Created by genglei on 2018/3/30.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ToolKitViewController.h"
#import "UniversaListCell.h"
#import "ModelPredictionViewModel.h"
#import "NullTableViewCell.h"
#import "ToolKitViewModel.h"
#import "BaolengZhishuVC.h"
#import "TongpeiTongjiVC.h"
#import "YapanZhoushouVC.h"
#import "PeilvYichangVC.h"
#import "JiXianVC.h"
#import "PanwangZhishuVC.h"
#import "JiaoYiViewController.h"
#import "BettingVC.h"

@interface ToolKitViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) BasicTableView *tableView;

@property (nonatomic, copy) NSArray *contentArray;

@end

@implementation ToolKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:YES];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationItem.title = @"工具";
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
    _contentArray = [ToolKitViewModel createModelListArray];
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
    NSInteger idnex = indexPath.row / 2;
    switch (idnex) {
        case 0: {
            BaolengZhishuVC * jiaoyi = [[BaolengZhishuVC alloc] init];
            [self.navigationController pushViewController:jiaoyi animated:YES];
        }
            break;
            
        case 1: {
            TongpeiTongjiVC *odd = [[TongpeiTongjiVC alloc] init];
            [self.navigationController pushViewController:odd animated:YES];
        }
            break;
            
        case 2: {
            YapanZhoushouVC *odd = [[YapanZhoushouVC alloc] init];
           [self.navigationController pushViewController:odd animated:YES];
        }
            break;
            
        case 3: {
            PeilvYichangVC *odd = [[PeilvYichangVC alloc] init];
            [self.navigationController pushViewController:odd animated:YES];
        }
            break;
            
        case 4: {
            JiXianVC *jixian = [[JiXianVC alloc] init];
            [self.navigationController pushViewController:jixian animated:YES];
        }
            break;
            
        case 5: {
            PanwangZhishuVC *record = [[PanwangZhishuVC alloc] init];
            [self.navigationController pushViewController:record animated:YES];
        }
            break;
            
        case 6: {
            JiaoYiViewController * jiaoyi = [[JiaoYiViewController alloc] init];
            [self.navigationController pushViewController:jiaoyi animated:YES];
        }
            break;
            
        case 7: {
            BettingVC *odd = [[BettingVC alloc] init];
           [self.navigationController pushViewController:odd animated:YES];
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
