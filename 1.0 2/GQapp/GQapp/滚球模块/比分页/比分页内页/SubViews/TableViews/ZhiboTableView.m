//
//  ZhiboTableView.m
//  GQapp
//
//  Created by WQ on 2017/8/11.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZhiboTableView.h"
#import "LiveEventMedel.h"
#import "liveLineupModel.h"
#import "TechModel.h"
#import "TechtwoModel.h"
#import "JishiFirstCell.h"
#import "JiShiPeiLvCell.h"
#import "PeiLvDetailCell.h"
#import "JiShiPeiLvDetailModel.h"
#import "LiveScoreModel.h"
#import "JiShiPeiLvDetailModel.h"
#import "DoubleBattlecell.h"
#import "PeiLvDetailVC.h"
#import "HSJFoldHeaderView.h"
#import "JSPLDownCell.h"
#import "JSPLDownMode.h"
#import "BisaiTongjiCell.h"
#import "BisaiTongjiCellTwo.h"
#import "BisaiTJHeaderView.h"
#import "BattleModel.h"
#import "JSPLDownMode.h"
#import "JSPLDownTwoModel.h"
#import "TongJiModel.h"
#define jiShiPeilvDetailCellID         @"jiShiPeilvDetailCell"
#define jiShiFirstCellID               @"jiShiPeiLvFirstCell"
#define doubleBattleCell               @"DoubleBattlecell"
#define jSPLDownCelliD                   @"jSPLDownCell"
#define cellBisaiTongji @"cellBisaiTongji"
#define cellBisaiTongjiTwo @"cellBisaiTongjiTwo"
typedef NS_ENUM(NSInteger,zhiboSegMenttype)
{
    jiShiPLType = 0,
    doubleBattleType = 1,
    bisaiTongjiType = 2,
    
};

@interface ZhiboTableView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,FoldSectionHeaderViewDelegate,SRWebSocketDelegate>
{
    NSTimer* _timer;
    NSInteger num;
}
@property (nonatomic, strong) NSString *defaultTitle;

//0：即时赔率  1：比赛统计  2：双方阵容
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *event;
@property (nonatomic, strong) NSArray *gueststatis;
@property (nonatomic, strong) NSArray *tech;
@property (nonatomic, strong) NSArray *techtwo;
@property (nonatomic, strong) NSArray *homestatis;
@property (nonatomic, strong) NSMutableArray *upArr;
@property (nonatomic, strong) NSMutableArray *backArr;

//"角球让球赔率"
@property (nonatomic, strong) JSPLDownMode *jsplDownone;
//"角球大小赔率"
@property (nonatomic, strong) JSPLDownTwoModel *jsplDownTwo;




//@"让分即时赔率",@"大小即时赔率",@"角球让球赔率",@"角球大小赔率"
@property (nonatomic, strong) NSMutableArray *LetGoalArr;

//@"让分即时赔率",
@property (nonatomic, strong) NSString *LetGoalOddsString;
@property (nonatomic, strong) NSMutableArray *LetGoalStep2Arr;


@property (nonatomic, strong) NSMutableArray *OUOddsArr;


//"大小即时赔率"
@property (nonatomic, strong) NSString *OUOddsString;
@property (nonatomic, strong) NSMutableArray *OUOddsStep2Arr;



@property (nonatomic, strong) NSMutableArray              *titleArr;
@property (nonatomic, strong) NSMutableArray              *doubleTitleArr;
@property (nonatomic, strong) NSMutableDictionary         *foldInfoDic;
@property (nonatomic, strong) NSMutableDictionary         *batFoldDic;
@property (nonatomic, assign) zhiboSegMenttype            segmentType;

//点击展开或者收起cell
@property (nonatomic, strong) NSMutableArray *showBisaiTongjiCell;
@property (nonatomic, strong) NSArray *arrBisaiTongjiTitle;

@end
@implementation ZhiboTableView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.defaultTitle = @"暂无数据";
        _showBisaiTongjiCell = [NSMutableArray arrayWithObjects:@"1",@"1",@"1", nil];
        _arrBisaiTongjiTitle = [NSArray arrayWithObjects:@"0",@"技术分析",@"比赛时间", nil];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[JishiFirstCell class] forCellReuseIdentifier:jiShiFirstCellID];
        [self registerClass:[JiShiPeiLvCell class] forCellReuseIdentifier:jiShiPeilvDetailCellID];
        [self registerClass:[DoubleBattlecell class] forCellReuseIdentifier:doubleBattleCell];
        [self registerClass:[JSPLDownCell class] forCellReuseIdentifier:jSPLDownCelliD];
        [self registerClass:[BisaiTongjiCell class] forCellReuseIdentifier:cellBisaiTongji];
        [self registerClass:[BisaiTongjiCellTwo class] forCellReuseIdentifier:cellBisaiTongjiTwo];
        
        self.delegate =self;
        self.dataSource = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.backgroundColor = [UIColor whiteColor];
        [self setupTableViewMJHeader];
        //
        num=1;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"reloadtabletongzhi" object:nil];
        
    }
    return self;
}
- (void)InfoNotificationAction:(NSNotification *)notification{
   // [self reloadData];
}
- (void)setModel:(LiveScoreModel *)model
{
    _model = model;
    
    NSMutableArray *arrEvent = [NSMutableArray array];
    
    LiveEventMedel *start = [[LiveEventMedel alloc] init];
    start.headerOrFooter = 1;
    
    LiveEventMedel *end = [[LiveEventMedel alloc] init];
    end.headerOrFooter = 2;
    
    [arrEvent addObject:end];
    [arrEvent insertObject:start atIndex:0];
    
    _event = [NSArray arrayWithArray:arrEvent];
    if (self.model.matchstate>=0) {
        [self Reconnect];
    }
    
    [self loadJiShiPLData];
    [self loadDataZhiBo];
    [self loadDoubleBatData];
    [self creatArr];
    
    
}
- (NSMutableArray *)titleArr {
    
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"让分即时赔率",@"大小即时赔率",@"角球让球赔率",@"角球大小赔率", nil];
    }
    return _titleArr;
}

- (NSMutableArray *)doubleTitleArr {
    
    if (!_doubleTitleArr) {
        _doubleTitleArr = [NSMutableArray arrayWithObjects:@"首发阵容",@"替补阵容", nil];
    }
    return _doubleTitleArr;
}

- (void)creatArr {
    _foldInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   @"0":@"1",
                                                                   @"1":@"1",
                                                                   @"2":@"1",
                                                                   @"3":@"1"
                                                                   }];
    _batFoldDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                  @"0":@"1",
                                                                  @"1":@"1"
                                                                  }];
}

- (void)addSegMent
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(Width*4, 0, Width, 60)];
    viewHeader.backgroundColor = [UIColor whiteColor];
    [self.superview addSubview:viewHeader];
    //@"即时赔率"
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"即时赔率",@"比赛统计",@"双方阵容"]];
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    segment.frame = CGRectMake(0, 15, 85*3, 30);
    segment.center = CGPointMake(Width/2, segment.center.y);
    segment.tintColor = redcolor;
    
    segment.selectedSegmentIndex = 1;
    [self changIndex:segment];
    [segment addTarget:self action:@selector(changIndex:) forControlEvents:UIControlEventValueChanged];
    [viewHeader addSubview:segment];
    
}

- (void)changIndex:(UISegmentedControl *)segment
{
    
    _currentIndex = segment.selectedSegmentIndex;
    NSLog(@"选择的按钮=%ld",_currentIndex);
    
    
    switch (_currentIndex) {
        case 0:
            self.segmentType = jiShiPLType;
            break;
        case 1: //1
            self.segmentType = bisaiTongjiType;
            break;
            
        case 2: //2
            self.segmentType = doubleBattleType;
            break;
        default:
            break;
    }
    [self reloadData];
}

#pragma mark -- UITableViewDataSource

- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    switch (_currentIndex) {
        case 0:
        {
            
            if (self.LetGoalStep2Arr.count == 0 && self.OUOddsStep2Arr.count ==0 && self.jsplDownone == nil && self.jsplDownTwo == nil ) {
                self.defaultTitle = @"暂无比赛数据";
                
            }else{
                self.defaultTitle = @"";
                NSString *text = @"暂无比赛数据";
                NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
                return [[NSAttributedString alloc] initWithString:text attributes:attributes];
                
            }

        }
            break;
        case 1: //1
        {
            if (_tech.count == 0 && _event.count ==0 && _techtwo.count == 0) {
                self.defaultTitle = @"暂无比赛数据";
                
            }else{
                self.defaultTitle = @"";
                NSString *text = @"暂无比赛数据";
                NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
                return [[NSAttributedString alloc] initWithString:text attributes:attributes];

            }
        }
            break;
        case 2: //2
        {
            if (_upArr.count == 0 && _backArr.count == 0) {
                self.defaultTitle = @"暂无相关数据";
                
            }else{
                self.defaultTitle = @"";
                NSString *text = @"暂无比赛数据";
                NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
                return [[NSAttributedString alloc] initWithString:text attributes:attributes];
                
            }
        }
            break;
            
        default:
            break;
    }
    
    NSString *text = self.defaultTitle;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    
    switch (_currentIndex) {
        case 0:
        {
            if (self.LetGoalStep2Arr.count == 0 && self.OUOddsStep2Arr.count ==0 && self.jsplDownone == nil && self.jsplDownTwo == nil) {
                return [UIImage imageNamed:@"d1"];
                
            }else{
                return [UIImage imageNamed:@"white"];

            }
        }
            break;
        case 1: //1
        {
            if (_tech.count == 0 && _event.count ==0 && _techtwo.count == 0) {
                return [UIImage imageNamed:@"d1"];
                
            }else{
                return [UIImage imageNamed:@"white"];
                
            }
        }
            break;
        case 2: //2
        {
            if (_upArr.count == 0 && _backArr.count == 0) {
                return [UIImage imageNamed:@"d1"];
                
            }else{
                return [UIImage imageNamed:@"white"];
                
            }
        }
            break;
            
        default:
            break;
    }
    
    if ([self.defaultTitle isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
        
    }
    return [UIImage imageNamed:@"d1"];
}

//是否允许滚动 (默认是 NO) :
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    
    return -60 - 60/2;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (_currentIndex) {
        case 0:
        {
            return self.titleArr.count;
        }
            break;
        case 1: //1
        {
            return 3;
        }
            break;
        case 2: //2
        {
            return self.doubleTitleArr.count;
        }
            break;
        case 3: //2
        {
            return self.doubleTitleArr.count;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (_currentIndex) {
        case 0:
            
            //            return [NSString stringWithFormat:@"%@",self.titleArr[section]];
            break;
            
        default:
            break;
        case 1:
            
            break;
        case 2:
            
            //            return  [NSString stringWithFormat:@"%@",self.doubleTitleArr[section]];
            break;
    }
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    switch (_currentIndex) {
        case 0:
        {
            
            
            if (section == 2 ) {
                
                if (self.jsplDownone == nil ) {
                 
                    return nil;
                }else{
                    
                    HSJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
                    if (!headerView) {
                        headerView = [[HSJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
                    }
                    
                    [headerView setFoldSectionHeaderViewWithTitle:[NSString stringWithFormat:@"%@",self.titleArr[section]] detail:@"" type:HerderStyleTotal section:section canFold:YES];
                    headerView.delegate = self;
                    headerView.YLineHided = NO;
                    headerView.contentView.backgroundColor = colorfbfafa;
                    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
                    
                    BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
                    headerView.fold = folded;
                    
                    return headerView;
                }
            }else if (section == 3) {
                
                if (self.jsplDownTwo == nil) {
                    
                    return nil;
                }else{
                    
                    HSJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
                    if (!headerView) {
                        headerView = [[HSJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
                    }
                    
                    [headerView setFoldSectionHeaderViewWithTitle:[NSString stringWithFormat:@"%@",self.titleArr[section]] detail:@"" type:HerderStyleTotal section:section canFold:YES];
                    headerView.delegate = self;
                    headerView.YLineHided = NO;
                    headerView.contentView.backgroundColor = colorfbfafa;
                    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
                    
                    BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
                    headerView.fold = folded;
                    
                    return headerView;
                }
            }else{
                
                HSJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
                if (!headerView) {
                    headerView = [[HSJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
                }
                
                [headerView setFoldSectionHeaderViewWithTitle:[NSString stringWithFormat:@"%@",self.titleArr[section]] detail:@"" type:HerderStyleTotal section:section canFold:YES];
                headerView.delegate = self;
                headerView.YLineHided = NO;
                headerView.contentView.backgroundColor = colorfbfafa;
                NSString *key = [NSString stringWithFormat:@"%d", (int)section];
                
                BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
                headerView.fold = folded;
                if (self.LetGoalStep2Arr.count == 0 && self.OUOddsStep2Arr.count ==0 && self.jsplDownone == nil && self.jsplDownTwo == nil) {
                    headerView.rightViewHided = YES;
                }
                
                return headerView;
            }

            
            
                /*
                switch (section) {
                    case 3:
                    {
                        if (self.jsplDownone == nil) {

                            return [UIView new];
                        }else{
                        
                            HSJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
                            if (!headerView) {
                                headerView = [[HSJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
                            }
                            
                            [headerView setFoldSectionHeaderViewWithTitle:[NSString stringWithFormat:@"%@",self.titleArr[section]] detail:@"" type:HerderStyleTotal section:section canFold:YES];
                            headerView.delegate = self;
                            headerView.YLineHided = NO;
                            headerView.contentView.backgroundColor = colorfbfafa;
                            NSString *key = [NSString stringWithFormat:@"%d", (int)section];
                            
                            BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
                            headerView.fold = folded;
                            
                            return headerView;
                        }

                    }
                        break;
                    case 4:
                    {
                        if (self.jsplDownTwo == nil) {
                            
                            return [UIView new];
                        }else{
                            
                            HSJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
                            if (!headerView) {
                                headerView = [[HSJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
                            }
                            
                            [headerView setFoldSectionHeaderViewWithTitle:[NSString stringWithFormat:@"%@",self.titleArr[section]] detail:@"" type:HerderStyleTotal section:section canFold:YES];
                            headerView.delegate = self;
                            headerView.YLineHided = NO;
                            headerView.contentView.backgroundColor = colorfbfafa;
                            NSString *key = [NSString stringWithFormat:@"%d", (int)section];
                            
                            BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
                            headerView.fold = folded;
                            
                            return headerView;
                        }

                    }
                        break;
                        
                    default:
                        break;
                }
                
            }else{
                
                
            }
                 */
                 
        }
            break;
                 
        case 1: //1
        {
            
            switch (section) {
                case 0:
                {
                    if (_techtwo.count == 0) {
                        return nil;
                    }
                    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 170)];
                    //                    header.contentView.backgroundColor = colorTableViewBackgroundColor;
                    BisaiTJHeaderView *view = [[BisaiTJHeaderView alloc] initWithFrame:CGRectMake(0, 0, Width, 170)];
                    
                    [header addSubview:view];
                    view.arrdata = _techtwo;
                    return header;
                    
                }
                    break;
                case 1:
                {
                    
                    if (_tech.count == 0) {
                        return nil;
                    }
                    HSJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//                    headerView.contentView.backgroundColor = redcolor;
                    if (!headerView) {
                        headerView = [[HSJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
                    }
                    
                    [headerView setFoldSectionHeaderViewWithTitle:[NSString stringWithFormat:@"%@",self.arrBisaiTongjiTitle[section]] detail:@"" type:HerderStyleTotal section:section canFold:YES];
                    headerView.delegate = self;
                    
                    BOOL folded = [[_showBisaiTongjiCell objectAtIndex:section] boolValue];
                    headerView.fold = folded;
                    headerView.contentView.backgroundColor = colorfbfafa;
                    headerView.rightViewHided = YES;
                    
                    return headerView;
                }
                    break;
                case 2:
                {
                    if (_event.count == 0) {
                        return nil;
                    }
                    HSJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
                    if (!headerView) {
                        headerView = [[HSJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
                    }
                    
                    [headerView setFoldSectionHeaderViewWithTitle:[NSString stringWithFormat:@"%@",self.arrBisaiTongjiTitle[section]] detail:@"" type:HerderStyleTotal section:section canFold:YES];
                    headerView.delegate = self;
                    
                    BOOL folded = [[_showBisaiTongjiCell objectAtIndex:section] boolValue];
                    headerView.fold = folded;
                    headerView.contentView.backgroundColor = colorfbfafa;
                    headerView.rightViewHided = YES;
                    
                    return headerView;
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 2: //2
        {
            if (_upArr.count == 0 && _backArr.count == 0) {
                return nil;
            }
            HSJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];

            if (!headerView) {
                headerView = [[HSJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
            }
            
            [headerView setFoldSectionHeaderViewWithTitle:[NSString stringWithFormat:@"%@",self.doubleTitleArr[section]] detail:@"" type:HerderStyleTotal section:section canFold:YES];
                headerView.contentView.backgroundColor = colorEEEEEE;
            headerView.delegate = self;
            NSString *key = [NSString stringWithFormat:@"%d", (int)section];
            
            BOOL folded = [[_batFoldDic valueForKey:key] boolValue];
            headerView.fold = folded;
            
            return headerView;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    switch (_currentIndex) {
        case 0:
        {
            switch (section) {
                case 0:
                {
                    return self.LetGoalStep2Arr.count == 0 ? 0.00001 : 42;
                }
                    break;
                case 1:
                {
                    return self.OUOddsStep2Arr.count == 0 ? 0.00001 : 42;
                }
                    break;
                case 2:
                {
                    return self.jsplDownone == nil ? 0.00001 : 42;
                }
                    break;
                case 3:
                {
                    return self.jsplDownTwo == nil ? 0.00001 :  42;
                }
                    break;
                default:
                    break;
            }
            return 42;
        }
            break;
        case 1: //1
        {
            
            switch (section) {
                case 0:
                {
                    if (_techtwo.count == 0) {
                        return 0.00001;
                    }
                    return 170;
                }
                    break;
                case 1:
                {
                    if (_tech.count == 0) {
                        return 0.00001;
                    }
                    return 42;
                }
                    break;
                case 2:
                {
                    
                    if (_event.count == 0) {
                        return 0.000001;
                    }
                    return 42;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 2: //2
        {
            if (_upArr.count == 0 && _backArr.count == 0 ) {
                return 0.00001;
            }
            return 42;
        }
            break;
            
        default:
            break;
    }
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    switch (_currentIndex) {
        case 0:
        {
            return nil;
        }
            break;
        case 1:
        {
            if (section == 2) {
                
                //            if (_event.count == 0) {
                //                return nil;
                //            }
                //
                //            if ([_showBisaiTongjiCell[section] intValue] == 0) {
                //                return nil;
                //            }
                UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 55)];
                footer.backgroundColor = [UIColor whiteColor];
                
                CGFloat imageWidth = 320;
                if (isOniPhone4 || isOniPhone5) {
                    imageWidth = 300;
                }
                
                UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, 55)];
                imageV.center = CGPointMake(Width/2, 55/2);
                imageV.image = [UIImage imageNamed:@"bisaiLong"];
                [footer addSubview:imageV];
                return footer;
                
            }else if(section == 1){
                
                UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
                footer.backgroundColor = [UIColor whiteColor];
                
                return footer;
                
            }
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (_currentIndex) {
        case 0:
        {
            return  0.0001;
        }
            break;
        case 1:
        {
            if (section == 2) {
                return 55;
                
                //            if (_event.count == 0) {
                //                return 0.000001;
                //            }
                //            return [_showBisaiTongjiCell[section] intValue] == 1 ? 55 :0.000001;
                //
                //            return 55;
            }else if(section == 1){
                
                return 20;
            }
        }
            break;
        default:
            break;
    }

    return 0.000001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    switch (_currentIndex) {
        case 0:
        {
            NSString *key = [NSString stringWithFormat:@"%d", (int)section];
            BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
            
            switch (section) {
                case 0:
                {
                    if (self.LetGoalStep2Arr.count ==0) {
                     
                        return 0;
                    }else{
                    
                        return folded ? self.LetGoalStep2Arr.count + 1 :0;
                    }
                }
                    break;
                case 1:
                {
                    if (self.OUOddsStep2Arr.count == 0) {
                        
                        return 0;
                    }else{
                    
                        return folded ? self.OUOddsStep2Arr.count + 1 :0;
                    }
                }
                    break;
                case 2:
                {
                    if (self.jsplDownone == nil) {
                    
                        return 0;
                    }else{
                    
                        return folded ? 1:0;
                    }
                }
                    break;
                case 3:
                {
                    if (self.jsplDownTwo == nil) {
                        
                        return 0;
                    }else{
                    
                        return folded ? 1:0;
                    }
                    
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 1: //1
        {
            switch (section) {
                case 0:
                {
                    return 0;
                }
                    break;
                case 2:
                {
                   // return [_showBisaiTongjiCell[section] intValue] == 1 ? _event.count :0;
                    return _event.count;
                }
                    break;
                case 1:
                {
                    return [_showBisaiTongjiCell[section] intValue] == 1 ? _tech.count :0;
                    return _tech.count;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 2: //2
        {
            // 修改
            NSString *key = [NSString stringWithFormat:@"%d", (int)section];
            BOOL folded = [[_batFoldDic objectForKey:key] boolValue];
            if (section == 0) {
                
                return folded? _upArr.count :0;
            }else{
                
                
                return folded? _backArr.count :0;
            }
            
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (_currentIndex) {
        case 0:
        {
            switch (indexPath.section) {
                case 0:
                {
                    return 35;
                }
                    break;
                case 1:
                {
                    return 35;
                }
                    break;
                case 2:
                {
                    return self.jsplDownone == nil ? 0.00001 : 35;
                }
                    break;
                case 3:
                {
                    return self.jsplDownTwo == nil ? 0.00001 : 35;
                }
                    break;
            }
        }
            break;
        case 1: //1
        {
            switch (indexPath.section) {
                case 0:
                {
                    
                }
                    break;
                case 2:
                {
                    return 60;
                }
                    break;
                case 1:
                {
                    return 40;
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (_currentIndex) {
        case 0:
        {
            if (indexPath.section == 0 ) {
            
                if (indexPath.row == 0) {
                    
                    JishiFirstCell *jiShiCell = [tableView dequeueReusableCellWithIdentifier:jiShiFirstCellID forIndexPath:indexPath];
                    jiShiCell.jiShiPLFirstModel = [JiShiPLFirstModel new];
                    jiShiCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    return jiShiCell;
                }else {
                    
                    JiShiPeiLvCell *jiShiPeiLvCell = [tableView cellForRowAtIndexPath:indexPath];
                    if (!jiShiPeiLvCell) {
                        jiShiPeiLvCell = [[JiShiPeiLvCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jiShiPeilvDetailCellID];
                    }
                    
                    if (_LetGoalStep2Arr.count > 0) {
                        
                        jiShiPeiLvCell.jsplArr = _LetGoalStep2Arr[indexPath.row - 1];
                    }
                    jiShiPeiLvCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    jiShiPeiLvCell.backgroundColor = colorFFFFFF;
                    
                    return jiShiPeiLvCell;
                }
            }else if (indexPath.section == 1) {
               
                if (indexPath.row == 0) {
                    
                    JishiFirstCell *jiShiCell = [tableView dequeueReusableCellWithIdentifier:jiShiFirstCellID forIndexPath:indexPath];
                    jiShiCell.jiShiPLFirstModel = [JiShiPLFirstModel new];
                    jiShiCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    return jiShiCell;
                }else {
                    
                    JiShiPeiLvCell *jiShiPeiLvCell = [tableView cellForRowAtIndexPath:indexPath];
                    if (!jiShiPeiLvCell) {
                        jiShiPeiLvCell = [[JiShiPeiLvCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jiShiPeilvDetailCellID];
                    }
                    if (_OUOddsStep2Arr.count > 0) {
                        
                        jiShiPeiLvCell.jsplTwoArr = _OUOddsStep2Arr[indexPath.row - 1];
                    }
                    jiShiPeiLvCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    jiShiPeiLvCell.backgroundColor = colorFFFFFF;
                    
                    return jiShiPeiLvCell;
                }

            }else if(indexPath.section == 2){//角球大小赔率
                
                JSPLDownCell *jSPLDownC = [tableView cellForRowAtIndexPath:indexPath];
                if (!jSPLDownC) {
                    jSPLDownC = [[JSPLDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jSPLDownCelliD];
                }
                jSPLDownC.jsplDwonModel = _jsplDownone;
                jSPLDownC.selectionStyle = UITableViewCellSelectionStyleNone;
                jSPLDownC.backgroundColor = colorFFFFFF;
                
                return jSPLDownC;
                
            }else if(indexPath.section == 3){
               
                JSPLDownCell *jSPLDownTwo = [tableView cellForRowAtIndexPath:indexPath];
                if (!jSPLDownTwo) {
                    jSPLDownTwo = [[JSPLDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jSPLDownCelliD];
                }
                jSPLDownTwo.jsplDwonTwoModel = _jsplDownTwo;
                jSPLDownTwo.selectionStyle = UITableViewCellSelectionStyleNone;
                jSPLDownTwo.backgroundColor = colorFFFFFF;
                
                return jSPLDownTwo;
            }
            
        }
            break;
        case 1:
        {
            switch (indexPath.section) {
                case 0:
                {
                    
                }
                    break;
                case 2:
                {
                    BisaiTongjiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellBisaiTongji];
                    if (!cell) {
                        cell = [[BisaiTongjiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellBisaiTongji];
                    }
                    
                    
                    //cell.model = _event[indexPath.row];
//                    [cell setModel:[_event objectAtIndex:indexPath.row]];
                    LiveEventMedel*model=_event[indexPath.row];
                    [cell tongjimmodel:model];
                    NSLog(@"_event-%@",_event);
                    cell.selectionStyle =UITableViewCellSelectionStyleNone;
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                    return cell;
                }
                    break;
                case 1:
                {
                    BisaiTongjiCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellBisaiTongjiTwo];
                    if (!cell) {
                        cell = [[BisaiTongjiCellTwo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellBisaiTongjiTwo];
                    }
                    
                    cell.model = [_tech objectAtIndex:indexPath.row];
                    cell.selectionStyle =UITableViewCellSelectionStyleNone;
                    return cell;
                    return [UITableViewCell new];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {
            switch (indexPath.section) {
                case 0:
                {
                    DoubleBattlecell *battleCell = [tableView dequeueReusableCellWithIdentifier:doubleBattleCell forIndexPath:indexPath];
                    
                    if (_upArr.count > 0) {
                        
                        battleCell.battlModel = [_upArr objectAtIndex:indexPath.row];
                    }
                    battleCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return battleCell;
                }
                    break;
                case 1:
                {
                    DoubleBattlecell *battleCell = [tableView dequeueReusableCellWithIdentifier:doubleBattleCell forIndexPath:indexPath];
                    
                    if (_backArr.count > 0) {
                        
                        battleCell.battlModel = [_backArr objectAtIndex:indexPath.row];
                    }
                    battleCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return battleCell;
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
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (_currentIndex) {
        case 0:
        {
            if (indexPath.section == 0 || indexPath.section == 1) {
                
                PeiLvDetailVC *peilvDDT = [[PeiLvDetailVC alloc]init];
                peilvDDT.PeiLvCType = isBeforeTwo;
                peilvDDT.hidesBottomBarWhenPushed = YES;
                peilvDDT.model = self.model;
                [APPDELEGATE.customTabbar pushToViewController:peilvDDT animated:YES];
            }else{
                
                PeiLvDetailVC *peilvDDT = [[PeiLvDetailVC alloc]init];
                peilvDDT.PeiLvCType = isAfterTwo;
                peilvDDT.hidesBottomBarWhenPushed = YES;
                peilvDDT.model = self.model;
                [APPDELEGATE.customTabbar pushToViewController:peilvDDT animated:YES];
            }
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    
    if (_currentIndex == 1 && section == 0) {
      
        return;
    }
//    else{
//    
//        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//        header.textLabel.font = [UIFont systemFontOfSize:14];
//        header.contentView.backgroundColor = colorEEEEEE;
//    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (!_cellCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        
        _cellCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTableViewFrame" object:nil];//到顶通知父视图改变状态
    }
}

#pragma mark - FoldSectionHeaderViewDelegate -
- (void)foldHeaderInSection:(NSInteger)SectionHeader {
    
    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    
    if (_segmentType == jiShiPLType) {
        
        BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
        NSString *fold = folded ? @"0" : @"1";
        [_foldInfoDic setValue:fold forKey:key];
    }else if (_segmentType == doubleBattleType){
        
        BOOL batFolded = [[_batFoldDic objectForKey:key] boolValue];
        NSString *batFold = batFolded ? @"0" : @"1";
        [_batFoldDic setValue:batFold forKey:key];
    }else if (_segmentType == bisaiTongjiType){
        
//        [_showBisaiTongjiCell replaceObjectAtIndex:SectionHeader withObject:([_showBisaiTongjiCell[SectionHeader] intValue] == 0)? @"1" : @"0"];
        
    }
    
    [self reloadData];
    
    //    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:SectionHeader];
    //    [self reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
}


- (void)sepreLetGoalArr {

    _LetGoalArr = [[NSMutableArray alloc] initWithArray: [_LetGoalOddsString componentsSeparatedByString:@","]];
    [_LetGoalArr removeObjectAtIndex:0];
    _LetGoalStep2Arr = [NSMutableArray array];
    
    for (int i = 0 ; i < _LetGoalArr.count; i++) {
       
        [_LetGoalStep2Arr addObject:[_LetGoalArr[i] componentsSeparatedByString:@"^"]];
    }
}

- (void)sepreOUOddArr {
    
    _OUOddsArr = [[NSMutableArray alloc] initWithArray: [_OUOddsString componentsSeparatedByString:@","]];
    [_OUOddsArr removeObjectAtIndex:0];
    _OUOddsStep2Arr = [NSMutableArray array];
    
    for (int i = 0 ; i < _OUOddsArr.count; i++) {
        
        [_OUOddsStep2Arr addObject:[_OUOddsArr[i] componentsSeparatedByString:@"^"]];
    }
}

#pragma mark - loadJiShiPLData -
- (void)loadJiShiPLData {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadJiShiPLData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *lsURl = [NSString stringWithFormat:@"%@%@%ld",APPDELEGATE.url_ServerQiuTan,url_JiShiPeiLv,(long)self.model.mid];
    NSLog(@"即使赔率请求链接=%@",lsURl);
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:lsURl Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
   
    } Success:^(id responseResult, id responseOrignal) {
        
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            self.defaultTitle = @"";
            NSLog(@"即使赔率请求结果=%@",responseOrignal);
            _jsplDownone = [JSPLDownMode entityFromDictionary:[[[responseOrignal objectForKey:@"data"] objectForKey:@"CornerOdds"] objectForKey:@"Rf_Odds"]];
            _jsplDownTwo = [JSPLDownTwoModel entityFromDictionary:[[[responseOrignal objectForKey:@"data"] objectForKey:@"CornerOdds"] objectForKey:@"Dx_Odds"]];
            //让分即时赔率
            _LetGoalOddsString = [NSString stringWithString:[[responseOrignal objectForKey:@"data"] objectForKey:@"LetGoalOddsString"]];
            //大小即时赔率
            _OUOddsString = [NSString stringWithString:[[responseOrignal objectForKey:@"data"] objectForKey:@"OUOddsString"]];
          
            [self sepreLetGoalArr];
            [self sepreOUOddArr];
            [self reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
    }];
}
#pragma mark - loadDoubleBatData -
- (void)loadDoubleBatData {
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:[NSString stringWithFormat:@"%@%@%ld.json",APPDELEGATE.url_jsonHeader,@"/jsbf/live/newbacklive_",(long)self.model.mid] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
//        self.defaultTitle = @"";
        NSLog(@"双方阵容=%@",responseOrignal);
        
        if ([responseOrignal objectForKey:@"up"]) {
            
            _upArr = [[NSMutableArray alloc] initWithArray:[BattleModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"up"]]];
            if (_upArr.count>0) {
                BattleModel*model=[BattleModel new];
                model.homenumber=@"";
                model.guestnumber=@"";
                model.homename=self.model.hometeam;
                model.guestname=self.model.guestteam;
                model.homeplayerid=111111111;
                model.homeplace=@"";
                
                [_upArr insertObject:model atIndex:0];
            }
            
        }
        if ([responseOrignal objectForKey:@"back"]) {
            
            _backArr = [[NSMutableArray alloc] initWithArray:[BattleModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"back"]]];
            if (_backArr.count>0) {
                BattleModel*model=[BattleModel new];
                model.homenumber=@"";
                model.guestnumber=@"";
                model.homename=self.model.hometeam;
                model.guestname=self.model.guestteam;
                model.homeplayerid=111111111;
                model.homeplace=@"";
                [_backArr insertObject:model atIndex:0];
            }
            
        }
        
        [self reloadData];
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultTitle = errorDict;
        
    }];
}
//比赛统计数据请求
- (void)loadDataZhiBo{
    
    //    self.model.mid 1396897
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:[NSString stringWithFormat:@"%@%@%ld.json",APPDELEGATE.url_jsonHeader,@"/jsbf/live/newlive_",(long)self.model.mid] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"统计返回=%@",responseOrignal);
        _event = [[NSMutableArray alloc] initWithArray:[LiveEventMedel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"event"]]];
        NSLog(@"返回的数据111=%ld",_event.count);
        LiveEventMedel *start = [[LiveEventMedel alloc] init];
        start.headerOrFooter = 1;
        start.ishome=99;
        start.time=99;
        start.teamid=99;
        start.type=99;
        start.name=@"";
        [_event insertObject:start atIndex:0];
        
        LiveEventMedel *end = [[LiveEventMedel alloc] init];
        end.headerOrFooter = 2;
        end.ishome=100;
        end.time=100;
        end.teamid=100;
        end.type=100;
        end.name=@"";
        [_event addObject:end];
        _event=(NSMutableArray *)[[_event reverseObjectEnumerator] allObjects];
        NSLog(@"返回的数据1222=%ld",_event.count);
       // _event = [NSMutableArray arrayWithObject:arrEvent];
NSLog(@"返回的数据333=%ld",_event.count);
        
        if ([responseOrignal objectForKey:@"tech"]) {
            _tech = [[NSArray alloc] initWithArray:[TechModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"tech"]]];
        }
        if ([responseOrignal objectForKey:@"techtwo"]) {
            _techtwo = [[NSArray alloc] initWithArray:[TechtwoModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"techtwo"]]];
        }
        
        if ([responseOrignal objectForKey:@"homestatis"]) {
            _homestatis =[[NSArray alloc] initWithArray:[liveLineupModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"homestatis"]]];
        }
        if ([responseOrignal objectForKey:@"gueststatis"]) {
            _gueststatis = [[NSArray alloc] initWithArray:[liveLineupModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"gueststatis"]]];
        }
        
                [self reloadData];
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
    }];
    
    
    
}
/*
 
 *让球$$大小$$角球$$统计  数据的及时更新
 */
//初始化
- (void)Reconnect{
    self.webSocket.delegate = nil;
    [self.webSocket close];
    //    ws://echo.websocket.org 测试地址
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/zoudi?sid=%ld",APPDELEGATE.url_JISHUIDATA,(long)self.model.mid]]]];
    self.webSocket.delegate = self;
    
   // self.title = @"Opening Connection...";
    
    [self.webSocket open];
}
//成功连接
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");
    
    //self.title = @"Connected!";
}
//连接失败，打印错误信息
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@":( Websocket Failed With Error %@", error);
    //self.title = @"Connection Failed! (see logs)";
    self.webSocket = nil;
    [self Reconnect];
}
//接收服务器发送信息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"及时更新的数据Received %@", message);
        if (_LetGoalOddsString==nil||[_LetGoalOddsString isEqualToString:@""]) {
            [self loadJiShiPLData];
            return;
        }
    NSLog(@"\n老数据=%@",_LetGoalStep2Arr[_LetGoalStep2Arr.count-1]);
    //让球$$大小$$角球$$统计
    /*
     * 1403196,10591627^76^0^1^全^0.93^2.5^0.93^0.91^1.5^0.95^3^0$$
     */
    NSMutableArray*DataArray = [[NSMutableArray alloc] initWithArray: [message componentsSeparatedByString:@"$$"]];
    
    NSLog(@"DataArray=%ld",DataArray.count);
                     
    NSMutableArray*Array=[[NSMutableArray alloc] initWithArray: [DataArray[0] componentsSeparatedByString:@","]];
    if (Array.count>1) {
        
    NSMutableArray*RangQiuArray=[[NSMutableArray alloc] initWithArray: [Array[1] componentsSeparatedByString:@"^"]];
        [RangQiuArray addObject:@"1"];
        NSMutableArray*oldArray=_LetGoalStep2Arr[_LetGoalStep2Arr.count-1];
        if ([@"半" isEqualToString:[NSString stringWithFormat:@"%@",RangQiuArray[4]]]) {
            return;
        }
        if ([oldArray[8] floatValue]>[RangQiuArray[8] floatValue]) {
//          1 绿色   2 红色
            [RangQiuArray addObject:@"1"];
            
        }else if([oldArray[8] floatValue]<[RangQiuArray[8] floatValue]){

            [RangQiuArray addObject:@"2"];
        }else{
            [RangQiuArray addObject:@"3"];
        }
        if ([oldArray[10] floatValue]>[RangQiuArray[10] floatValue]) {
            //         1 绿色    2 红色
            [RangQiuArray addObject:@"1"];
            
        }else if([oldArray[10] floatValue]<[RangQiuArray[10] floatValue]){
            [RangQiuArray addObject:@"2"];
        }else{
            [RangQiuArray addObject:@"3"];
        }
        
        //判断比分是否相等
        if (oldArray[2]==RangQiuArray[2]&&oldArray[3]==RangQiuArray[3]) {
            [_LetGoalStep2Arr replaceObjectAtIndex:_LetGoalStep2Arr.count-1 withObject:RangQiuArray];
        }else{
            if (RangQiuArray[1]>=oldArray[1]) {
                [_LetGoalStep2Arr addObject:RangQiuArray];
            }
            
        }
        NSMutableArray*arr=_LetGoalStep2Arr[_LetGoalStep2Arr.count-2];
//        if (arr.count>13) {
//            [arr subarrayWithRange:NSMakeRange(0, 12)];
//        }
        [_LetGoalStep2Arr replaceObjectAtIndex:_LetGoalStep2Arr.count-2 withObject:arr];
        
        NSLog(@"\n让球及时更新=%@\n老数据=%@",RangQiuArray[1],_LetGoalStep2Arr[_LetGoalStep2Arr.count-1]);
    }
    //大小即时赔率
    NSMutableArray*DArray=[[NSMutableArray alloc] initWithArray: [DataArray[1] componentsSeparatedByString:@","]];
    if (DArray.count>1) {
    
    NSMutableArray*DaXiaoArray=[[NSMutableArray alloc] initWithArray: [DArray[1] componentsSeparatedByString:@"^"]];
        if ([@"半" isEqualToString:[NSString stringWithFormat:@"%@",DaXiaoArray[4]]]) {
            return;
        }
        NSMutableArray*DoldArray=_OUOddsStep2Arr[_OUOddsStep2Arr.count-1];
        if ([DoldArray[8] floatValue]>[DaXiaoArray[8] floatValue]) {
            //             2 红色
            [DaXiaoArray addObject:@"1"];
            
        }else if([DoldArray[8] floatValue]<[DaXiaoArray[8] floatValue]){
            //            1 绿色
            [DaXiaoArray addObject:@"2"];
        }else{
            [DaXiaoArray addObject:@"3"];
        }
        if ([DoldArray[10] floatValue]>[DaXiaoArray[10] floatValue]) {
            //             2 红色
            [DaXiaoArray addObject:@"1"];
            
        }else if([DoldArray[10] floatValue]<[DaXiaoArray[10] floatValue]){
            //            1 绿色
            [DaXiaoArray addObject:@"2"];
        }else{
            [DaXiaoArray addObject:@"3"];
        }

        if (DoldArray[2]==DaXiaoArray[2]&&DoldArray[3]==DaXiaoArray[3]) {
            [_OUOddsStep2Arr replaceObjectAtIndex:_OUOddsStep2Arr.count-1 withObject:DaXiaoArray];
        }else{
            if (DaXiaoArray[1]>=DoldArray[1]) {
                [_OUOddsStep2Arr addObject:DaXiaoArray];
            }
            
        }
        NSMutableArray*arr=_OUOddsStep2Arr[_OUOddsStep2Arr.count-2];
//        if (arr.count>13) {
//            [arr subarrayWithRange:NSMakeRange(0, 12)];
//        }
        [_OUOddsStep2Arr replaceObjectAtIndex:_OUOddsStep2Arr.count-2 withObject:arr];
    }
    NSMutableArray*JiaoQiuArray=[[NSMutableArray alloc] initWithArray: [DataArray[2] componentsSeparatedByString:@","]];
    
    if (JiaoQiuArray.count>1) {
        if (_jsplDownTwo.Js_Goal>[JiaoQiuArray[3] floatValue]) {
            _jsplDownTwo.Js_Goal2=1;
        }else if(_jsplDownTwo.Js_Goal<[JiaoQiuArray[3] floatValue]){
            _jsplDownTwo.Js_Goal2=2;
        }else{
            _jsplDownTwo.Js_Goal2=3;

        }
        if (_jsplDownTwo.Js_Down>[JiaoQiuArray[5] floatValue]) {
            _jsplDownTwo.Js_Down2=1;
        }else if(_jsplDownTwo.Js_Down<[JiaoQiuArray[5] floatValue]){
            _jsplDownTwo.Js_Down2=2;
        }else{
            _jsplDownTwo.Js_Down2=3;
            
        }
        _jsplDownTwo.Js_Goal=[JiaoQiuArray[3] floatValue];
        _jsplDownTwo.Js_Up=[JiaoQiuArray[4] floatValue];
        _jsplDownTwo.Js_Down=[JiaoQiuArray[5] floatValue];
        
    }
    // NSMutableArray*TongJiArray=[[NSMutableArray alloc] initWithArray: [DataArray[3] componentsSeparatedByString:@","]];
    NSString*ddd=DataArray[3];
    if (ddd.length>0) {

    }
    NSDictionary*TongJiDic=[self dictionaryWithJsonString:ddd];
    
//    TongJiModel*tongjimdel=DataArray[3];
    if (ddd.length>0) {
    
        NSMutableArray *arrEvent = [[NSMutableArray alloc] initWithArray:[LiveEventMedel arrayOfEntitiesFromArray:[TongJiDic objectForKey:@"event"]]];
        
        LiveEventMedel *start = [[LiveEventMedel alloc] init];
        start.headerOrFooter = 1;
        
        LiveEventMedel *end = [[LiveEventMedel alloc] init];
        end.headerOrFooter = 2;
        
        [arrEvent addObject:end];
        [arrEvent insertObject:start atIndex:0];
        
        _event = [NSArray arrayWithArray:arrEvent];
        
        
        if ([TongJiDic objectForKey:@"tech"]) {
            _tech = [[NSArray alloc] initWithArray:[TechModel arrayOfEntitiesFromArray:[TongJiDic objectForKey:@"tech"]]];
        }
        if ([TongJiDic objectForKey:@"techtwo"]) {
            _techtwo = [[NSArray alloc] initWithArray:[TechtwoModel arrayOfEntitiesFromArray:[TongJiDic objectForKey:@"techtwo"]]];
        }
        
        if ([TongJiDic objectForKey:@"homestatis"]) {
            _homestatis =[[NSArray alloc] initWithArray:[liveLineupModel arrayOfEntitiesFromArray:[TongJiDic objectForKey:@"homestatis"]]];
        }
        if ([TongJiDic objectForKey:@"gueststatis"]) {
            _gueststatis = [[NSArray alloc] initWithArray:[liveLineupModel arrayOfEntitiesFromArray:[TongJiDic objectForKey:@"gueststatis"]]];
        }

    }else{
        [self loadDataZhiBo];
    }
    
    
    
    [self reloadData];
    
//    NSNotification *notification =[NSNotification notificationWithName:@"reloadtabletongzhi" object:nil userInfo:nil];
//    //通过通知中心发送通知
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
   _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerChangeData) userInfo:nil repeats:NO];
    //        [_timer fire];
    
    
    //_webZhiBo.UpdateString=message;
    // self.showTxt.text = message;
}
-(void)timerChangeData{
    if (num>1) {
        num=1;
        if (_LetGoalStep2Arr.count>1) {
            NSMutableArray*arr=_LetGoalStep2Arr[_LetGoalStep2Arr.count-1];
            NSMutableArray*arr2=_OUOddsStep2Arr[_OUOddsStep2Arr.count-1];
            if (arr.count>13) {
                [arr replaceObjectAtIndex:13 withObject:@"000"];
                [arr replaceObjectAtIndex:14 withObject:@"000"];
                
            }
            if (arr2.count>13) {
                [arr2 replaceObjectAtIndex:13 withObject:@"000"];
                [arr2 replaceObjectAtIndex:14 withObject:@"000"];
            }
            [self reloadData];
            [_timer invalidate];
            _timer=nil;
            return;

        }
           }
    num++;
    
}
// 长连接关闭
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"WebSocket closed");
    //self.title = @"Connection Closed! (see logs)";
    self.webSocket = nil;
}
//该函数是接收服务器发送的pong消息
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"%@",reply);
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
