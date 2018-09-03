//
//  ZBBaolengTable.m
//  GQapp
//
//  Created by WQ on 2017/8/31.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#define  cellBaolengZhishuVC @"cellBaolengZhishuVC"
#import "ZBBaolengZhishuCell.h"
#import "ZBBaolengDetailVC.h"
#import "ZBBaolengZishuModel.h"

#import "ZBBaolengTable.h"
@interface ZBBaolengTable()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, retain)NSArray *arrData;

//0 全部  1 热门  2竞彩  3北单
@property (nonatomic, assign) NSInteger currentIndex;

@end
@implementation ZBBaolengTable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.defaultTitle = @"";
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[ZBBaolengZhishuCell class] forCellReuseIdentifier:cellBaolengZhishuVC];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate =self;
        self.dataSource = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];

    }
    return self;
}

#pragma mark -- UITableViewDataSource

- (void)updateWithType:(NSInteger)type
{
    _currentIndex = type;
    [self loadBaolengData];
    
}

- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.mj_header endRefreshing];
        [self loadBaolengData];

    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultTitle isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];

    }
    
    if ([self.defaultTitle isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"d1"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultTitle isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];

    }
    
    NSString *text = self.defaultTitle;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
//    header.backgroundColor = [UIColor whiteColor];
//    
//    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
//    labTitle.font = font12;
//    labTitle.textColor = color66;
//    labTitle.text = @"比赛";
//    [header addSubview:labTitle];
//    
//    UILabel *labbaolengTime = [[UILabel alloc] initWithFrame:CGRectMake(Width - 70, 0, 0, 30)];
//    labbaolengTime.font = font12;
//    labbaolengTime.textColor = color66;
//    labbaolengTime.text = @"";
//    [header addSubview:labbaolengTime];
//    
//    UILabel *labbaolengZhishu = [[UILabel alloc] initWithFrame:CGRectMake(Width - 110, 0, 110, 30)];
//    labbaolengZhishu.font = font12;
//    labbaolengZhishu.textColor = color66;
//    labbaolengZhishu.textAlignment = NSTextAlignmentCenter;
//    labbaolengZhishu.text = @"爆冷指数";
//    [header addSubview:labbaolengZhishu];
//    
//    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 29, Width, 0.5)];
//    viewLine.backgroundColor = colorCellLine;
//    [header addSubview:viewLine];
//    
//    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBBaolengZhishuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellBaolengZhishuVC];
    if (!cell) {
        cell = [[ZBBaolengZhishuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellBaolengZhishuVC];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    cell.model = [_arrData objectAtIndex:indexPath.row];
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBBaolengDetailVC *baolengDT = [[ZBBaolengDetailVC alloc] init];
    ZBBaolengZishuModel* model = [_arrData objectAtIndex:indexPath.row];
    baolengDT.idId =model.idId;
    baolengDT.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:baolengDT animated:YES];
}

- (void)loadBaolengData
{
    NSString *mtype = @"";
    switch (_currentIndex) {
        case 0:
        {
            mtype = @"0";
        }
            break;
        case 1:
        {
            mtype = @"4";
        }
            break;
        case 2:
        {
            mtype = @"1";
        }
            break;
        case 3:
        {
            mtype = @"2";
        }
            break;
            
        default:
            break;
    }
    
    //    全部 热门 竞彩 北单

    
    [[ZBDependetNetMethods sharedInstance] requeSurprisestatisWithType:mtype Start:^(id requestOrignal) {
        
//        [ZBLodingAnimateView showLodingView];
    } End:^(id responseOrignal) {
//        [ZBLodingAnimateView dissMissLoadingView];
        
    } Success:^(id responseResult, id responseOrignal) {
        
        if ([[responseOrignal objectForKey:@"code"] intValue] == 200) {
            
            self.defaultTitle = @"暂无数据";

            _arrData = [NSArray arrayWithArray:[ZBBaolengZishuModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            [self reloadData];
            
        }else{
        self.defaultTitle = [responseOrignal objectForKey:@"msg"];
            [self reloadData];

        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultTitle = errorDict;
        
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        [self reloadData];

    }];
}

@end
