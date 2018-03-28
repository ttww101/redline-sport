//
//  NewQingbaoTableView.m
//  GQapp
//
//  Created by WQ_h on 16/5/9.
//  Copyright © 2016年 GQXX. All rights reserved.
//
#define cellNewQB @"cellNewQB"
#import "NewQingbaoTableView.h"
#import "NewQBTableViewCell.h"
#import "TimeModel.h"
#import "RightSlidetabletableViewCell.h"

static NSString * iden = @"testTime";

@interface NewQingbaoTableView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, assign) CGFloat oldContentY;
@property(strong,nonatomic)NSMutableArray * dataList;

@end

@implementation NewQingbaoTableView

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
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.delegate = self;
    self.dataSource = self;
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    [self registerClass:[NewQBTableViewCell class] forCellReuseIdentifier:cellNewQB];
    [self registerClass:[RightSlidetabletableViewCell class] forCellReuseIdentifier:iden];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    [self setupMJ_header];
    [self reloadData];
}
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    [self reloadData];
}
- (void)setupMJ_header
{
    MJRefreshNormalHeader *_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshdata)];
    _header.lastUpdatedTimeLabel.hidden = YES;
    _header.stateLabel.font = font13;
    self.mj_header = _header;

}

//-(void)setData {
//    
//    NSMutableArray *timeArr = [NSMutableArray arrayWithArray:self.jiDianArr];
//    self.dataList=[NSMutableArray arrayWithCapacity:0];
//    
//    for (int i = 0 ; i < timeArr.count; i++) {
//        
//        NSDictionary *dic=@{@"titleStr":@"马赛中场核心，状态糟糕"};
//        TimeModel *model=[[TimeModel alloc]initData:dic];
//        [self.dataList addObject:model];
//    }
//}

- (void)setJiDianArr:(NSMutableArray *)jiDianArr {
    
    _jiDianArr = jiDianArr;
    self.dataList = [NSMutableArray array];
    [self.dataList addObjectsFromArray:jiDianArr];

}

//Data Source 实现方法
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"d1"];
}
//返回标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无情报，你要做头条吗";
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    
        return -80;
    
}
-(void)headerRefreshdata
{
    if (_delegateNewQB && [_delegateNewQB respondsToSelector:@selector(headerRefreshNewQB)]) {
        [_delegateNewQB headerRefreshNewQB];
    };
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (self.arrhomeInfo.count == 0 && self.arrneutralInfo.count == 0 && self.arrawayInfo.count == 0) {
//        
//        return 1;
//    }

    return 4; // 3
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.arrhomeInfo.count == 0 && self.arrneutralInfo.count == 0 && self.arrawayInfo.count == 0) {
//        
//        return 0;
//    }
    switch (section) {
        case 0:
            return self.arrhomeInfo.count;
            break;
        case 1:
            return self.arrneutralInfo.count;
            break;
        case 2:
            return self.arrawayInfo.count;
            break;
        case 3:
            return self.jiDianArr.count;
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [tableView fd_heightForCellWithIdentifier:cellNewQB cacheByIndexPath:indexPath configuration:^(NewQBTableViewCell* cell) {
//        
//        switch (indexPath.section) {
//            case 0:
//            {
//                InfoListModel *infoModel = [self.arrhomeInfo objectAtIndex:indexPath.row];
//                cell.model = infoModel;
//
//            }
//                break;
//            case 1:
//            {
//                InfoListModel *infoModel = [self.arrneutralInfo objectAtIndex:indexPath.row];
//                cell.model = infoModel;
//                
//            }
//                break;
//            case 2:
//            {
//                InfoListModel *infoModel = [self.arrawayInfo objectAtIndex:indexPath.row];
//                cell.model = infoModel;
//                
//            }
//                break;
//
//            default:
//                break;
//        }
//
//            }];
    
    
    switch (indexPath.section) {
        case 0:
        {
            InfoListModel *infoModel = [self.arrhomeInfo objectAtIndex:indexPath.row];
            
            CGFloat heiContent = [Methods getTextHeightStationWidth:[NSString stringWithFormat:@"%@",infoModel.content] anWidthTxtt:Width - 30 anfont:14 andLineSpace:5.5 andHeaderIndent:0];
    
            CGFloat heiTitle = [Methods getTextHeightStationWidth:infoModel.title anWidthTxtt:Width - 30 anfont:20 andLineSpace:5 andHeaderIndent:0];
            return 60 + heiContent + heiTitle;
        }
            break;
        case 1:
        {
            InfoListModel *infoModel = [self.arrneutralInfo objectAtIndex:indexPath.row];
            CGFloat heiContent = [Methods getTextHeightStationWidth:[NSString stringWithFormat:@"%@",infoModel.content] anWidthTxtt:Width - 30 anfont:14 andLineSpace:5.5 andHeaderIndent:0];
            
            CGFloat heiTitle = [Methods getTextHeightStationWidth:infoModel.title anWidthTxtt:Width - 30 anfont:20 andLineSpace:5 andHeaderIndent:0];
            return 60 + heiContent + heiTitle;
            
        }
            break;
        case 2:
        {
            InfoListModel *infoModel = [self.arrawayInfo objectAtIndex:indexPath.row];
            CGFloat heiContent = [Methods getTextHeightStationWidth:[NSString stringWithFormat:@"%@",infoModel.content] anWidthTxtt:Width - 30 anfont:14 andLineSpace:5.5 andHeaderIndent:0];
            CGFloat heiTitle = [Methods getTextHeightStationWidth:infoModel.title anWidthTxtt:Width - 30 anfont:20 andLineSpace:5 andHeaderIndent:0];
            
            return 60 + heiContent + heiTitle;
        }
            break;
        case 3:
        {
//            if (self.jiDianArr.count > 0) {
            
            TimeModel * model = self.jiDianArr[indexPath.row];
            NSDictionary * fontDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGSize size1 = CGSizeMake(WIDTH_OF_PROCESS_LABLE, 0);
            CGSize titleLabelSize=[model.title boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:fontDic context:nil].size;
//            if (titleLabelSize.height < 15) {
//                titleLabelSize.height = 40;
//            }else{
//                titleLabelSize.height = titleLabelSize.height + 30;
//            }
            return titleLabelSize.height + 40;
//            return 60;
//        }
        }
            break;
    
        default:
            break;
    }
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NewQBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNewQB];
    if (!cell) {
        cell = [[NewQBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNewQB];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        switch (indexPath.section) {
            case 0:
            {
                InfoListModel *infoModel = [self.arrhomeInfo objectAtIndex:indexPath.row];
                cell.model = infoModel;
                
            }
                break;
            case 1:
            {
                InfoListModel *infoModel = [self.arrneutralInfo objectAtIndex:indexPath.row];
                cell.model = infoModel;
                
            }
                break;
            case 2:
            {
                InfoListModel *infoModel = [self.arrawayInfo objectAtIndex:indexPath.row];
                cell.model = infoModel;
                
            }
                break;
            case 3:
            {
                RightSlidetabletableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
                if (!cell) {
                    cell = [[RightSlidetabletableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
                }
//                if (self.dataList.count > 0) {
                
                    TimeModel * timemodel = self.dataList[indexPath.row];
                    cell.model = timemodel;
//                }
                return cell;
            }
                break;
            default:
                break;
        }
    return cell;

    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return self.arrhomeInfo.count== 0? 0.00001: 35;
            break;
        case 1:
            return self.arrneutralInfo.count == 0? 0.00001: 35;
            break;
        case 2:
            return self.arrawayInfo.count == 0? 0.00001: 35;
            break;
        case 3:
            return self.jiDianArr.count == 0? 0.00001 : 35;
            break;
        default:
            break;
    }

    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
        {
            if (self.arrhomeInfo.count == 0) {
                return nil;
            }
        }
            break;
        case 1:
        {
            if (self.arrneutralInfo.count == 0) {
                return nil;
            }
        }
            break;
        case 2:
        {
            if (self.arrawayInfo.count == 0) {
                return nil;
            }
        }
            break;
        case 3:
        {
            if (self.jiDianArr.count == 0) {
                return nil;
            }
        }
            break;

        default:
            break;
    }

    
//    NewQBModel *model = [_arrData objectAtIndex:section];
//    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 12, Width - 30, 1)];
//    viewLine.backgroundColor = colorTableViewBackgroundColor;
//    [header addSubview:viewLine];
//    
//    UIView *viewLeft = [[UIView alloc] initWithFrame:CGRectMake(15, 12, 1, 13)];
//    viewLeft.backgroundColor = colorTableViewBackgroundColor;
//    [header addSubview:viewLeft];
//    

    UIView *header= [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 35)];
//    header.backgroundColor = [UIColor whiteColor];
    header.backgroundColor = colorf5f5f5;
    
    

    switch (section) {
        case 0:
        {
            InfoListModel *infoModel = [self.arrhomeInfo objectAtIndex:0];
            
            UILabel *labName =  [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 104, 35)];
            labName.font = font14;
            
            labName.text = infoModel.HomeTeam;
            labName.textColor = redcolor;
            [header addSubview:labName];
            
        }
            break;
        case 1:
        {
//            InfoListModel *infoModel = [self.arrneutralInfo objectAtIndex:0];
            UILabel *labName =  [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 104, 35)];
            labName.font = font14;
            labName.textColor = color33;
            
            labName.text = @"中立";
//            labName.textColor = color40;
            [header addSubview:labName];

        }
            break;
        case 2:
        {
            InfoListModel *infoModel = [self.arrawayInfo objectAtIndex:0];
   
            UILabel *labName =  [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 104, 35)];
            labName.font = font14;
            
            labName.text = infoModel.GuestTeam;
            labName.textColor = blue1Color;
            [header addSubview:labName];
            
        }
            break;
        case 3:
        {
            UIView *rolView = [[UIView alloc] initWithFrame:CGRectMake(15, 12, 12, 12)];
            rolView.backgroundColor = redcolor;
            rolView.layer.cornerRadius = 6;
            
            UILabel *labName =  [[UILabel alloc] initWithFrame:CGRectMake(37, 0, Width - 104, 35)];
            labName.text = @"提点数据";
            labName.font = font14;
            labName.textColor = redcolor;
            
            [header addSubview:rolView];
            [header addSubview:labName];
        }
            break;
        default:
            break;
    }

    
    UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(0, 35, Width, 0.5)];
    viewRight.backgroundColor = colorDD;
    [header addSubview:viewRight];

    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 1)];
    footer.backgroundColor = [UIColor whiteColor];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 1)];
    viewLine.backgroundColor = colorTableViewBackgroundColor;
    [footer addSubview:viewLine];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
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

@end
