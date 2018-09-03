//
//  Record_OneModel.h
//  GQapp
//
//  Created by 叶忠阳 on 16/6/24.
//  Copyright © 2016年 GQXX. All rights reserved.
//   战绩特征


#import "BasicModel.h"

@interface Record_OneModel : BasicModel
@property (nonatomic, assign)NSInteger sid;//比赛id
@property (nonatomic, assign)NSInteger teamid;//球队id
@property (nonatomic, retain)NSString *teamname;//球队名称
@property (nonatomic, retain)NSString *result;//对应6场比赛的赛果，3：胜，1：平，0：负
@property (nonatomic, retain)NSString *mtime;//开赛时间
@property (nonatomic, retain)NSString *league;//联赛名称
@property (nonatomic, retain)NSString *hometeam;//主队名称
@property (nonatomic, retain)NSString *guestteam;//客队名称
//@property (nonatomic, assign)NSInteger win;//胜的场次
@property (nonatomic, assign)NSInteger lost;//负的场次
@property (nonatomic, assign)NSInteger mostresult;
@property (nonatomic, assign)NSInteger historymostresult;
//（按状态）

//@property (nonatomic, assign)NSInteger draw;//平的场次

//(按盘路)
@property (nonatomic, assign)NSInteger zou;

//(按赛果)
@property (nonatomic, retain)NSString *sort;
@property (nonatomic, retain)NSString *sortone;

@property (nonatomic, assign)NSInteger type;

//赔率
@property (nonatomic, strong) NSString *win;
@property (nonatomic, strong) NSString *draw;
@property (nonatomic, strong) NSString *lose;


@end
