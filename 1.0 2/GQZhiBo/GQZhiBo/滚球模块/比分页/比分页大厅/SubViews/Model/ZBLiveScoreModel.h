//
//  ZBLiveScoreModel.h
//  GunQiuLive
//
//  Created by WQ_h on 16/2/3.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "ZBBasicModel.h"

@interface ZBLiveScoreModel : ZBBasicModel
/*
 请求参数：
	flag = 0，//赛事类型（0：全部赛事，1：竞彩，2：北单，3：足彩）
	visit，    //访问来源（为空的话来自pc，1-1000:ios）
	begin,     //开始时间,yyyy-MM-dd HH:mm:ss  （当天11:30:00,全部赛事，竞彩赛事传）
	end,       //结束时间,yyyy-MM-dd HH:mm:ss  （次日11:30:00,全部赛事，竞彩赛事传）
	name,      //期次名称 (北单、足彩赛事传)
 iscurrent  //是否当前期次，0：否，1：是 (北单、足彩赛事传)
 
 返回数据说明：
 code:200：查询成功，201：查询失败；desc：返回状态说明，time：服务器的当前时间；mid：比赛id，leagueId：联赛id，league：联赛名称，season：赛季名称，color：标色，
 mtime：开赛时间，htime：下半场开赛时间，homeId：主队id，guestId：客队id，homeTeam：主队名称，guestTeam：客队名称
 matchstate：比赛状态，（0:未开,1:上半场,2:中场,3:下半场,4,加时，-11:待定,-12:腰斩,-13:中断,-14:推迟,-1:完场，-10取消）
 homeScore:主队当前比分， guestScore：客队当前比分， halfHsc：主队上半场比分， halfGsc：客队上半场比分， homeRed：主队红牌数
 guestRed：客队红牌数， homeRank：主队排名， guestRank客队排名， neutrality：中立场，info：爆料总数，recommand:推荐总数
 letgoal：让球盘（亚盘），total：大小盘，standard：欧盘
 *盘口以逗号隔开，分别对应（上盘水位，盘口，下盘水位），如：0.85,0.5,0.95
 
 比赛进行的时间计算方式：上半场：服务器的当前时间-mtime的分钟数；下半场：（服务器的当前时间-htime的分钟数）+45 */
//@property (nonatomic, strong) NSString *Severtime;


/*
 
 1	天晴
 2	大致天晴
 3	间中有云
 4	多云
 5	微雨
 6	大雨
 7	雪
 8	雷暴
 9	地区性雷暴
 10	有雾
 11	中雨
 12	阴天
 13	雷陣雨
 
 */

@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *guestOrder;
@property (nonatomic, assign) NSInteger guestRed;
@property (nonatomic, assign) NSInteger guestYellow;
@property (nonatomic, assign) NSInteger guesthalfscore;
@property (nonatomic, assign) NSInteger guestscore;
@property (nonatomic, copy) NSString *guestteam;
@property (nonatomic, assign) NSInteger guestteamid;
@property (nonatomic, copy) NSString *homeOrder;
@property (nonatomic, assign) NSInteger homeRed;
@property (nonatomic, assign) NSInteger homeYellow;
@property (nonatomic, assign) NSInteger homehalfscore;
@property (nonatomic, assign) NSInteger homescore;
@property (nonatomic, copy) NSString *hometeam;
@property (nonatomic, assign) NSInteger hometeamid;
@property (nonatomic, copy) NSString *league;
//联赛颜色
@property (nonatomic, copy) NSString *leagueColor;

@property (nonatomic, assign) NSInteger leagueId;
//球场
@property (nonatomic, copy) NSString *location;
@property (nonatomic, assign) NSInteger matchstate;
@property (nonatomic, copy) NSString *matchtime;
@property (nonatomic, copy) NSString *matchtime2;
@property (nonatomic, assign) NSInteger mid;

@property (nonatomic, assign) BOOL neutrality;
@property (nonatomic, copy) NSString *season;
@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *weathericon;
//爆料
@property (nonatomic, assign) NSInteger info;
//推荐
@property (nonatomic, assign) NSInteger recommand;
//亚盘
@property (nonatomic, copy) NSString *letgoal;
//大盘
@property (nonatomic, copy) NSString *total;
//欧
@property (nonatomic, copy) NSString *standard;
//北单足彩才有的 标号
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *remark;

//角球
@property (nonatomic, copy) NSString *homeCorner;
@property (nonatomic, copy) NSString *guestCorner;
@property (nonatomic, copy) NSString *homeOrderNum;
@property (nonatomic, copy) NSString *guestOrderNum;

@property (nonatomic, assign) BOOL bgIsRed;

@end
