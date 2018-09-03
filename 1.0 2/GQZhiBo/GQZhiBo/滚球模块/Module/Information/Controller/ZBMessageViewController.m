//
//  ZBMessageViewController.m
//  newGQapp
//
//  Created by genglei on 2018/7/17.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ZBMessageViewController.h"
#import "ZBInfoViewModel.h"
#import "ZBInfoTableViewCell.h"
#import <YYModel/YYModel.h>
#import "ZBHeaderTableViewCell.h"
#import "ZBCommentsViewController.h"
#import "ZBCommentsDetailViewController.h"
@interface ZBMessageViewController () <UITableViewDataSource, UITableViewDelegate, InfoTableViewCellDelegate>

@property (nonatomic , strong) ZBInfoViewModel *viewModel;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) ZBInfoModel *model;

@end

@implementation ZBMessageViewController

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

#pragma mark - Load Data

- (void)loadData {
    __weak ZBMessageViewController *weakSelf = self;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parameter setValue:_newsID forKey:@"newsid"];
    [parameter setValue:@"true" forKey:@"hot"];
    [parameter setValue:@"-1" forKey:@"parentid"];
    [self.viewModel fetchRecommendedReviewsWithParameter:parameter callBack:^(BOOL isSucess, id response) {
        if (isSucess) {
            weakSelf.model = [ZBInfoModel yy_modelWithDictionary:(NSDictionary *)response];
            [weakSelf.tableView reloadData];
        } else {
            
        }
    }];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationItem.title = @"测试代码";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.data.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZBHeaderTableViewCell *cell = [ZBHeaderTableViewCell cellForTableView:tableView];
        cell.title = @"全部评论";
        return cell;
    }
    ZBInfoTableViewCell *cell = [ZBInfoTableViewCell cellForTableView:tableView];
    cell.delegate = self;
    cell.model = self.model.data[indexPath.row - 1];
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [ZBHeaderTableViewCell heightForCell];
    }
    return [ZBInfoTableViewCell heightForCell];
    
}

#pragma mark - InfoTableViewCellDelegate

- (void)tableViewCell:(ZBInfoTableViewCell *)cell likeComment:(UIButton *)comment {
     NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [parameter setValue:_newsID forKey:@"newsid"];
    [parameter setValue:cell.model.commentId forKey:@"parentid"];
    
    [[ZBDCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,info_like_url] ArrayFile:nil Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            cell.model.likeCount = cell.model.likeCount + 1;
            cell.model.liked = YES;
            NSIndexPath *index = [self.tableView indexPathForCell:cell];
            [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
       [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
    }];
}

- (void)tableViewCell:(ZBInfoTableViewCell *)cell moreComments:(id)moreComments {
    
    ZBCommentsViewController *control = [[ZBCommentsViewController alloc]init];
    control.ID = _newsID;
    [self.navigationController pushViewController:control animated:YES];
}

#pragma mark - Lazy Load

- (ZBInfoViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[ZBInfoViewModel alloc]init];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

@end
