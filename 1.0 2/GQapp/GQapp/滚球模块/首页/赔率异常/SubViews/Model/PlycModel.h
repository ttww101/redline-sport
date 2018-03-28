//
//  PlycModel.h
//  GQapp
//
//  Created by WQ on 2017/9/28.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"
#import "PanProcessModel.h"
@interface PlycModel : BasicModel

//赔率异常，亚盘助手，大小球盘口通用
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, assign) NSInteger companyId;

@property (nonatomic, strong) NSString *finalDraw;
@property (nonatomic, strong) NSString *finalLose;
@property (nonatomic, strong) NSString *finalWin;
@property (nonatomic, strong) NSString *firstDraw;
@property (nonatomic, strong) NSString *firstLose;
@property (nonatomic, strong) NSString *firstWin;
@property (nonatomic, strong) NSString *guestTeam;
@property (nonatomic, strong) NSString *homeTeam;
@property (nonatomic, strong) NSString *matchTime;
@property (nonatomic, strong) NSString *sclassName;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *amp;

@property (nonatomic, assign) NSInteger scheduleId;
@property (nonatomic, assign) NSInteger idId;



//赔率异常
@property (nonatomic, strong) NSString *loseAmp;
@property (nonatomic, strong) NSString *winAmp;
@property (nonatomic, strong) NSString *drawAmp;
@property (nonatomic, assign) NSInteger matchType;
@property (nonatomic, assign) NSInteger oddType;
@property (nonatomic, assign) NSTimeInterval statisTime;
@property (nonatomic, assign) NSInteger timeType;


//赔率异常：1胜赔   2平赔  3负赔
//亚盘助手：1 盘口监控   2水位监控
//大小球盘口：1 盘口监控   2水位监控
@property (nonatomic, assign) NSInteger type;


//亚盘助手 大小球盘口
@property (nonatomic, assign) NSInteger changeNum;
@property (nonatomic, strong) NSArray *panProcess;
@property (nonatomic, assign) NSTimeInterval finalTime;
@property (nonatomic, assign) NSTimeInterval firstTime;



@property (nonatomic, assign) NSInteger oddsId;
@property (nonatomic, strong) NSString *finalTimeCn;









@end
