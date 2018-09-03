//
//  ZBTongPeiTongjiTable.m
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#define cellTongPeiTongjiTable @"cellTongPeiTongjiTable"
#import "ZBTongbeiTongjiCell.h"
#import "ZBTongPeiTongjiTable.h"
#import "ZBTongPeiDetailVC.h"
@interface ZBTongPeiTongjiTable()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSArray *arrData;
//1：亚盘   2大小球  0胜平负
@property (nonatomic, assign) NSInteger type;
//0 全部  1 热门  2竞彩  3北单
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, retain)NSArray *arrTitle;

@end
@implementation ZBTongPeiTongjiTable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.defaultTitle = @"";
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[ZBTongbeiTongjiCell class] forCellReuseIdentifier:cellTongPeiTongjiTable];
        self.delegate =self;
        self.dataSource = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];

    }
    return self;
}

- (void)updateWithType:(NSInteger)type
{
    _arrTitle =@[@"全部",@"热门",@"竞彩",@"北单",] ;
    _currentIndex = 0;
    _type = type;
    [self loadTongpeiZhishuData];

}

- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.mj_header endRefreshing];
        [self loadTongpeiZhishuData];

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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    header.backgroundColor = [UIColor whiteColor];
    CGFloat wid = Width/_arrTitle.count;
    for (int i =0; i < _arrTitle.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(wid * i, 0, wid, 44);
        [btn setTitle:_arrTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:color66 forState:UIControlStateNormal];
        [btn setTitleColor:color33 forState:UIControlStateSelected];
        
        if (i == _currentIndex) {
            [btn.titleLabel setFont: BoldFont4(fontSize14)];
            
        }else{
            [btn.titleLabel setFont: font14];
            
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:btn];
        
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, Width, 0.5)];
    lineView.backgroundColor = colorDD;
    [header addSubview:lineView];
    
    return header;
}

- (void)clickBtn:(UIButton *)btn
{
    _currentIndex = btn.tag;
    [self loadTongpeiZhishuData];
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
    ZBTongbeiTongjiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTongPeiTongjiTable];
    if (!cell) {
        cell = [[ZBTongbeiTongjiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTongPeiTongjiTable];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    while ([cell.contentView.subviews lastObject]!= nil) {
    //        [[cell.contentView.subviews lastObject] removeFromSuperview];
    //    }
    cell.type = _type;
    if (_arrData.count >0) {
        
        cell.model = [_arrData objectAtIndex:indexPath.row];
    }
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBTongPeiDetailVC *tongPDT = [[ZBTongPeiDetailVC alloc] init];
    ZBTongPeiTJModel *model;
    if (_arrData.count > 0) {
        
        model = [_arrData objectAtIndex:indexPath.row];
    }
    tongPDT.scheduleId = model.scheduleId;
    tongPDT.sclassId = model.sclassId;
    tongPDT.pelvIndex = _type;
    tongPDT.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:tongPDT animated:YES];
}


- (void)loadTongpeiZhishuData
{
    NSMutableDictionary *patameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    
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
    [patameter setObject:mtype forKey:@"type"];
    [patameter setObject:[NSString stringWithFormat:@"%ld",_type + 1] forKey:@"playType"];

    [[ZBDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:patameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_sameOdd_index] Start:^(id requestOrignal) {
//        [ZBLodingAnimateView showLodingView];
    } End:^(id responseOrignal) {
//        [ZBLodingAnimateView dissMissLoadingView];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
           
//            _arrData = [NSArray arrayWithArray:[ZBTongPeiTJModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];

            
            _arrData = [NSArray arrayWithArray:[ZBTongPeiTJModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"] ]];
            self.defaultTitle = @"暂无数据";

            [self reloadData];
        }else{
            self.defaultTitle = [responseOrignal objectForKey:@"msg"];
            [self reloadData];

        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        self.defaultTitle = errorDict;
        [self reloadData];

    }];
}
@end
