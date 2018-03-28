//
//  PanwangZhishuTable.m
//  GQapp
//
//  Created by WQ on 2017/8/23.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#import "LiveScoreModel.h"
#import "FenxiPageVC.h"
#import "PanwangCell.h"
#import "PanwangZhishuTable.h"
#define cellPanwangCell @"cellPanwangCell"
@interface PanwangZhishuTable()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) NSInteger limitStart;
//0 全部  1 热门  2竞彩  3北单
@property (nonatomic, assign) NSInteger currentType;
@property (nonatomic, strong) NSArray *arrBtnTitle;
@property (nonatomic, assign) NSInteger isToFenxi;

@end
@implementation PanwangZhishuTable

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
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[PanwangCell class] forCellReuseIdentifier:cellPanwangCell];
        
        self.delegate =self;
        self.dataSource = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
    }
    return self;
}
- (void)setType:(NSString *)type
{
    _type = type;
    _arrBtnTitle = @[@"全部",@"热门",@"竞彩",@"北单",];

     
    if (_arrData.count == 0) {
        _arrData = [NSMutableArray array];
        _limitStart = 0;
        [self loadDataPanwangWithType:loadDataFirst];
    }
    
}
#pragma mark -- UITableViewDataSource


- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _arrData = [NSMutableArray array];
        _limitStart = 0;

        [self loadDataPanwangWithType:loadDataFirst];

    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _limitStart = _limitStart + 20;
        [self loadDataPanwangWithType:loadDataMoredata];
    }];
//    footer.automaticallyHidden = YES;
    [footer setTitle:@"已加载全部" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
    self.mj_footer.hidden = YES;

    
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *basView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 74)];
    basView.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat wid = Width/_arrBtnTitle.count;
    for (int i = 0; i < _arrBtnTitle.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(wid * i, 0, wid, 44);
        [btn setTitle:_arrBtnTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:color66 forState:UIControlStateNormal];
        [btn setTitleColor:color33 forState:UIControlStateSelected];
        btn.tag = i;
        if (i== _currentType) {
            btn.selected = YES;
            btn.titleLabel.font = BoldFont4(fontSize14);

        }else{
            btn.selected = NO;
            btn.titleLabel.font = font14;

        }
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [basView addSubview:btn];
        
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width, 0.5)];
    lineView.backgroundColor = colorDD;
    [basView addSubview:lineView];

    
    
    
    UILabel *labOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, 60, 30)];
    labOne.font = font12;
    labOne.textColor = color99;
    labOne.text = @"排名";
    labOne.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labOne];
    
    UILabel *labTwo = [[UILabel alloc] initWithFrame:CGRectMake(60, 44, 50, 30)];
    labTwo.font = font12;
    labTwo.textColor = color99;
    labTwo.text = @"球队";
    [basView addSubview:labTwo];
    
    
    
    UILabel *labBiLi = [[UILabel alloc] initWithFrame:CGRectMake(Width - 15 - 50, 44, 50 , 30)];
    labBiLi.font = font12;
    labBiLi.textColor = color99;
    labBiLi.text = @"概率";
    labBiLi.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labBiLi];
    
    UILabel *labJY = [[UILabel alloc] initWithFrame:CGRectMake(Width - 95 - 50, 44, 80, 30)];
    labJY.font = font12;
    labJY.textColor = color99;
    labJY.text = @"赛事";
    labJY.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labJY];
    
    
    
    UIView *lienView = [[UIView alloc] initWithFrame:CGRectMake(0, 73, Width, 0.5)];
    lienView.backgroundColor = colorDD;
    [basView addSubview:lienView];
    
    
   
    return basView;

}

- (void)clickBtn:(UIButton *)btn
{
    _currentType = btn.tag;
    _limitStart = 0;
    [_arrData removeAllObjects];
    [self loadDataPanwangWithType:loadDataFirst];
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 74;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PanwangCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPanwangCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[PanwangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellPanwangCell];
    }
    cell.rankNum = indexPath.row + 1;
    PanWangModel *model = self.arrData[indexPath.row];
    cell.model = model;
    
    
    
    switch ([_type integerValue]) {
        case 0:
        {
            switch (model.type) {
                case 1:
                {
                    cell.labGaiLv.textColor = redcolor;
                    cell.labGaiLvTitle.textColor = redcolor;
                    cell.labGaiLvTitle.text = @"胜率";
                }
                    break;
                case 2:
                {
                    cell.labGaiLv.textColor = bluecolor;
                    cell.labGaiLvTitle.textColor = bluecolor;
                    cell.labGaiLvTitle.text = @"平率";
                    
                }
                    break;
                case 3:
                {
                    cell.labGaiLv.textColor = greencolor;
                    cell.labGaiLvTitle.textColor = greencolor;
                    cell.labGaiLvTitle.text = @"负率";
                    
                }
                    break;
                    
                default:
                    break;
            }
            

        }
            break;
            
            
        case 1:
        {
            switch (model.type) {
                case 1:
                {
                    cell.labGaiLv.textColor = redcolor;
                    cell.labGaiLvTitle.textColor = redcolor;
                    cell.labGaiLvTitle.text = @"赢盘";
                }
                    break;
                case 2:
                {
                    cell.labGaiLv.textColor = bluecolor;
                    cell.labGaiLvTitle.textColor = bluecolor;
                    cell.labGaiLvTitle.text = @"";
                    
                }
                    break;
                case 3:
                {
                    cell.labGaiLv.textColor = greencolor;
                    cell.labGaiLvTitle.textColor = greencolor;
                    cell.labGaiLvTitle.text = @"输盘";
                    
                }
                    break;
                    
                default:
                    break;
            }
            
            
        }
            break;

            
        case 2:
        {
            switch (model.type) {
                case 1:
                {
                    cell.labGaiLv.textColor = redcolor;
                    cell.labGaiLvTitle.textColor = redcolor;
                    cell.labGaiLvTitle.text = @"大球";
                }
                    break;
                case 2:
                {
                    cell.labGaiLv.textColor = bluecolor;
                    cell.labGaiLvTitle.textColor = bluecolor;
                    cell.labGaiLvTitle.text = @"";
                    
                }
                    break;
                case 3:
                {
                    cell.labGaiLv.textColor = greencolor;
                    cell.labGaiLvTitle.textColor = greencolor;
                    cell.labGaiLvTitle.text = @"小球";
                    
                }
                    break;
                    
                default:
                    break;
            }
            
            
        }
            break;

        default:
            break;
    }
    
    

    
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PanWangModel *model = self.arrData[indexPath.row];
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
    }else{
        return;
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    
    [parameter setObject:@"3" forKey:@"flag"];
    [parameter setObject:@(model.sid) forKey:@"sid"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            
            LiveScoreModel *model = [LiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            //从首页跳转分析页的时候不用反转
            model.neutrality = NO;
            FenxiPageVC *fenxiVC = [[FenxiPageVC alloc] init];
            fenxiVC.model = model;
            fenxiVC.currentIndex = 0;
            fenxiVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
            
        }
        _isToFenxi = NO;
        
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _isToFenxi = NO;
        
    }];
    
}

- (void)loadDataPanwangWithType:(loadDataType)loadType
{
    
    [self.mj_footer resetNoMoreData];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@(1) forKey:@"stagestype"];
    [parameter setObject:@(1) forKey:@"probabilitype"];
    //1：胜平负  2：亚盘  3：大小球
    [parameter setObject:@( [_type intValue]+ 1) forKey:@"oddstype"];//segenement
    
    NSString *mtype = @"";
    switch (_currentType) {
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
    [parameter setObject:mtype forKey:@"mtype"];
    [parameter setObject:@(_limitStart) forKey:@"limitStart"];
    [parameter setObject:@(20) forKey:@"limitEnd"];
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,@"/recordodds"] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
        [self.mj_footer endRefreshing];
        [self.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        
        if ([[responseOrignal objectForKey:@"code"] intValue] == 200) {
            
            self.defaultTitle = @"暂无数据";
            NSArray *arr = [PanWangModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]];
            if (arr.count == 0) {
                if (loadType != loadDataMoredata){
                    _arrData = [[NSMutableArray alloc] initWithArray:arr];
                    //                    [_tableView setContentOffset:CGPointZero animated:YES];
                }else{
                    [self.mj_footer endRefreshingWithNoMoreData];
                }
                self.defaultPage = defaultPageThird;
                
                [self reloadData];
            }else{
                [self.arrData addObjectsFromArray:arr];
                if (arr.count<20) {
                    [self.mj_footer endRefreshingWithNoMoreData];

                }
                if (loadType == loadDataFirst) {
                    [self setContentOffset:CGPointZero];
                }
                [self reloadData];
                
                
                
            }
        }else{
            
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
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
