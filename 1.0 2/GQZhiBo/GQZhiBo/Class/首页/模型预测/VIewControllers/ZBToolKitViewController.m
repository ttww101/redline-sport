#import "ZBToolKitViewController.h"
#import "ZBUniversaListCell.h"
#import "ZBModelPredictionViewModel.h"
#import "ZBNullTableViewCell.h"
#import "ZBToolKitViewModel.h"
#import "ZBBaolengZhishuVC.h"
#import "ZBTongpeiTongjiVC.h"
#import "ZBYapanZhoushouVC.h"
#import "ZBPeilvYichangVC.h"
#import "ZBJiXianVC.h"
#import "ZBPanwangZhishuVC.h"
#import "ZBJiaoYiViewController.h"
#import "ZBBettingVC.h"
@interface ZBToolKitViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) ZBBasicTableView *tableView;
@property (nonatomic, copy) NSArray *contentArray;
@end
@implementation ZBToolKitViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    _contentArray = [ZBToolKitViewModel createModelListArray];
    [self.tableView reloadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentArray.count * 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        ZBNullTableViewCell *nullCell = [ZBNullTableViewCell cellForTableView:tableView];
        return nullCell;
    } else {
        ZBUniversaListCell *cell = [ZBUniversaListCell cellForTableView:tableView];
        [cell refreshContentData:_contentArray[indexPath.row / 2]];
        return cell;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return [ZBNullTableViewCell heightForCell];
    } else {
        return [ZBUniversaListCell heightForCell];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idnex = indexPath.row / 2;
    switch (idnex) {
        case 0: {
            ZBBaolengZhishuVC * jiaoyi = [[ZBBaolengZhishuVC alloc] init];
            [self.navigationController pushViewController:jiaoyi animated:YES];
        }
            break;
        case 1: {
            ZBTongpeiTongjiVC *odd = [[ZBTongpeiTongjiVC alloc] init];
            [self.navigationController pushViewController:odd animated:YES];
        }
            break;
        case 2: {
            ZBYapanZhoushouVC *odd = [[ZBYapanZhoushouVC alloc] init];
           [self.navigationController pushViewController:odd animated:YES];
        }
            break;
        case 3: {
            ZBPeilvYichangVC *odd = [[ZBPeilvYichangVC alloc] init];
            [self.navigationController pushViewController:odd animated:YES];
        }
            break;
        case 4: {
            ZBJiXianVC *jixian = [[ZBJiXianVC alloc] init];
            [self.navigationController pushViewController:jixian animated:YES];
        }
            break;
        case 5: {
            ZBPanwangZhishuVC *record = [[ZBPanwangZhishuVC alloc] init];
            [self.navigationController pushViewController:record animated:YES];
        }
            break;
        case 6: {
            ZBJiaoYiViewController * jiaoyi = [[ZBJiaoYiViewController alloc] init];
            [self.navigationController pushViewController:jiaoyi animated:YES];
        }
            break;
        case 7: {
            ZBBettingVC *odd = [[ZBBettingVC alloc] init];
           [self.navigationController pushViewController:odd animated:YES];
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
        _tableView = [[ZBBasicTableView alloc] initWithFrame:CGRectZero];
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
