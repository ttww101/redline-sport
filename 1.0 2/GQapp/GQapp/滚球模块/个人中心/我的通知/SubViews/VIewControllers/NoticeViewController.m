//
//  NoticeViewController.m
//  GQapp
//
//  Created by WQ_h on 16/4/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeModel.h"
#import "NoticeDetailViewController.h"
#define cellNotice @"cellNotice"
@interface NoticeViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) BasicTableView *tableView;
@property (nonatomic, strong) NSArray *arrData;
@end

@implementation NoticeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的通知";
    self.defaultFailure = @"";
    [self setupTableView];
    [self loadUreadNotification];
}
#pragma mark -- UITableViewDataSource
- (void)setupTableView
{
    self.tableView = [[BasicTableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellNotice];
//    self.tableView.backgroundColor = colorTableViewBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;

    [self.view addSubview:self.tableView];
}
//返回单张图片
//Data Source 实现方法
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    if ([self.defaultFailure isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
        
    }
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"d1"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNotice];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNotice];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    NoticeModel *model = [_arrData objectAtIndex:indexPath.row];
    
    
    UILabel *labNew = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 8, 8)];
    labNew.backgroundColor = redcolor;
    labNew.textColor = [UIColor clearColor];
    labNew.font = font12;
    labNew.layer.cornerRadius = 4;
    labNew.layer.masksToBounds = YES;
    labNew.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:labNew];

    
    
    UILabel *labtime = [[UILabel alloc] initWithFrame:CGRectMake(labNew.right + 10, 0, Width - labNew.right - 10 - 20, 18)];
    labtime.center = CGPointMake(labtime.center.x, labNew.center.y);
    labtime.textColor = color99;
    labtime.font = font10;
//    labtime.backgroundColor= redcolor;
    labtime.text = [model.time substringWithRange:NSMakeRange(5, 11)];
    [cell.contentView addSubview:labtime];
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(labtime.x, labtime.bottom, labtime.width, 22)];
    labTitle.font = font14;
    labTitle.text = model.title;
//    labTitle.backgroundColor = redcolor;
    [cell.contentView addSubview:labTitle];

    
    
    if (model.iread) {
        labNew.hidden = YES;
        labTitle.textColor = color66;
    }else{
        labNew.hidden = NO;
        labTitle.textColor = color33;
    }
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(20, 69, Width- 20, 0.6)];
    viewLine.backgroundColor = colorCellLine;
    [cell.contentView addSubview:viewLine];
    return cell;
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.arrData.count==0) {
        return;
    }
    NoticeModel *model = [_arrData objectAtIndex:indexPath.row];
    if (model.iread) {
        
    }else{
        [self updateNoticeWithNoticeId:model];
    }
    NoticeDetailViewController *noticeDVC = [[NoticeDetailViewController alloc] init];
    noticeDVC.model = model;
    noticeDVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:noticeDVC animated:YES];
}
-  (void)loadUreadNotification
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@"0" forKey:@"flag"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_noticedo] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrData = [[NSArray alloc] initWithArray:[NoticeModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            self.defaultFailure = @"暂无通知";

            [self.tableView reloadData];
            
        }else{
//        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];
            [self.tableView reloadData];

        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [self.tableView reloadData];

//        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}

-  (void)updateNoticeWithNoticeId:(NoticeModel *)model
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@"2" forKey:@"flag"];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)model.mid] forKey:@"mid"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_noticedo] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            model.iread = YES;
            
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
