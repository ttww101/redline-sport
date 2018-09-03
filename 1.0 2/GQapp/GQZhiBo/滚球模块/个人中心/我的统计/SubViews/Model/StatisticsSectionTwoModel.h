//
//  StatisticsSectionTwoModel.h
//  GQapp
//
//  Created by WQ_h on 16/8/16.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface StatisticsSectionTwoModel : BasicModel
@property (nonatomic, assign) NSInteger gonum;
@property (nonatomic, assign) NSInteger losenum;
@property (nonatomic, assign) NSInteger playtype;
@property (nonatomic, assign) NSInteger recommendCount;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, assign) NSInteger winnum;
@property (nonatomic, copy) NSString *winRate;
@property (nonatomic, copy) NSString *profitRate;
//欧赔,亚盘,大小球  串关统计
@property (nonatomic, copy) NSString *paninv;
//玩法统计
@property (nonatomic, copy) NSString *playname;
@property (nonatomic, copy) NSString *choicename;

//赛事统计
@property (nonatomic, copy) NSString *sclasscolor;
@property (nonatomic, copy) NSString *sclassname;
@property (nonatomic, assign) NSInteger sclassid;
//时间统计
@property (nonatomic, copy) NSString *timeinv;
//月赛事，每日赛事统计
@property (nonatomic, copy) NSString *unitstr;

//串关统计
//@property (nonatomic, copy) NSString *paninv;



@end
