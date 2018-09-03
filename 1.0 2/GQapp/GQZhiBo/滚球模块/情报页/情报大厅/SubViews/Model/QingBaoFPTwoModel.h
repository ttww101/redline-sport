//
//  QingBaoFPTwoModel.h
//  GQapp
//
//  Created by 叶忠阳 on 16/8/17.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface QingBaoFPTwoModel : BasicModel

@property (nonatomic, assign)NSInteger sid;//比赛id
@property (nonatomic, retain)NSString *league;//联赛名称
@property (nonatomic, assign)NSInteger leagueId;//联赛id
@property (nonatomic, retain)NSString *mtime;//比赛时间
@property (nonatomic, assign)NSInteger matchstate;//比赛状态
@property (nonatomic, retain)NSString *guestteam; //客队名称
@property (nonatomic, assign)NSInteger guestteamid;//客队id
@property (nonatomic, retain)NSString *hometeam;//  主队名称
@property (nonatomic, assign)NSInteger hometeamid;//主队id
@property (nonatomic, retain)NSString *homescore;//主队比分
@property (nonatomic, retain)NSString *guestscore;//客队比分
@property (nonatomic, assign)NSInteger newsid;//情报id
@property (nonatomic, assign)NSInteger choice;////立场，3：主，1：中，0：客
@property (nonatomic, retain)NSString *tag;//标签
@property (nonatomic, retain)NSString *title;//情报标题
@property (nonatomic, retain)NSString *content;//情报内容

@property (nonatomic, retain)NSString *upodds;//上盘
@property (nonatomic, retain)NSString *goals;//盘口
@property (nonatomic, retain)NSString *downodds;//下盘
@property (nonatomic, assign)NSInteger infoCount;

@property (nonatomic, assign)BOOL yOn;

@property (nonatomic, retain)NSString *sort;

@property (nonatomic, retain)NSString *leagueColor;

//@property (nonatomic, retain)NSString *matchintro;
@property (nonatomic, retain)NSString *color;
@property (nonatomic, retain)NSString *createtime;
@property (nonatomic, retain)NSString *weekDayName;
@property (nonatomic, assign)NSInteger mark;

@end
