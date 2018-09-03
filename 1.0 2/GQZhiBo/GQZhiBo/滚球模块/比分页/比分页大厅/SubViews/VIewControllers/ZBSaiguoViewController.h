//
//  ZBSaiguoViewController.h
//  GQapp
//
//  Created by WQ on 2016/12/21.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicViewController.h"

@interface ZBSaiguoViewController : ZBBasicViewController
@property (nonatomic, strong) NSMutableArray *arrData;
//全部选项里面的最新数据，为了更新每次请求大对阵里面的数据，大对阵里面的数据可能不是最新的
@property (nonatomic, strong)NSMutableArray *memeryArrAllPart;

@property (nonatomic, strong) UITableView *tableView;
//选择赛事里面全部的赛事数据
@property (nonatomic, strong) NSArray *arrSelectedSaishi;
//选择赛事里面竞彩的赛事数据
@property (nonatomic, strong) NSArray *arrSelectedSaishiJingcai;
//选择赛事里面初盘的赛事数据
@property (nonatomic, strong) NSArray *arrSelectedSaishiChupan;

- (void)refreshDataByChangeFlag:(NSInteger)flag;

@end
