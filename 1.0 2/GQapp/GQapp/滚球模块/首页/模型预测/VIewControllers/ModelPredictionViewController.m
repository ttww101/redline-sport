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
#import "ToolWebViewController.h"

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
    if (![Methods login]) {
        [Methods toLogin];
        return;
    }
    NSInteger idnex = indexPath.row / 2;
    switch (idnex) {
        case 0: {
            WebModel *model = [[WebModel alloc]init];
            model.title = @"胜平负";
            model.webUrl = [NSString stringWithFormat:@"%@/mx2/cpspfmode.html", APPDELEGATE.url_jsonHeader];
//             model.webUrl = [NSString stringWithFormat:@"%@:81/ios/spfmode.html", APPDELEGATE.url_jsonHeader];
            
            model.callHandleActionName = @"spfmode";
            model.registerActionName = @"toPage";
            model.showBuyBtn = YES;
            ToolWebViewController *webControl = [[ToolWebViewController alloc]init];
            webControl.model = model;
            [self.navigationController pushViewController:webControl animated:YES];
        }
            break;
            
        case 1: {
            WebModel *model = [[WebModel alloc]init];
            model.title = @"亚盘";
            model.webUrl = [NSString stringWithFormat:@"%@/mx2/cpyamode.html", APPDELEGATE.url_jsonHeader];
//            model.webUrl = [NSString stringWithFormat:@"%@:81/ios/yamode.html", APPDELEGATE.url_jsonHeader];
            model.callHandleActionName = @"yamode";
            model.registerActionName = @"toPage";
            model.showBuyBtn = YES;
            ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
            webDetailVC.model = model;
            [self.navigationController pushViewController:webDetailVC animated:YES];
            
        }
            break;
            
        case 2: {
            WebModel *model = [[WebModel alloc]init];
            model.title = @"大小球";
            model.webUrl = [NSString stringWithFormat:@"%@/mx2/dxmode.html", APPDELEGATE.url_jsonHeader];
//            model.webUrl = [NSString stringWithFormat:@"%@:81/ios/dxmode.html", APPDELEGATE.url_jsonHeader];
            model.callHandleActionName = @"dxmode";
            model.registerActionName = @"toPage";
            model.showBuyBtn = YES;
            ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
            webDetailVC.model = model;
            [self.navigationController pushViewController:webDetailVC animated:YES];
            
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
