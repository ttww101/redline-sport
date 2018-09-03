//
//  StatisticsModel.h
//  GQapp
//
//  Created by WQ_h on 16/4/1.
//  Copyright © 2016年 GQXX. All rights reserved.
//

/*
 a)	code：状态码
 b)	msg：消息结果描述
 c)	data：json数据如下：
 "data":{
 "avgweeknum" : 9, 		//平均每周推荐数
 "focus_count":0, 		//粉丝数
 "follower_count":3,		//关注数
 "gonum":2,			//用户总走盘数
 "goodplay":{			//擅长玩法对象
 "gonum":0,			//走水数
 "losenum":14,			//输盘数
 "playname":"胜平负",	//玩法名称
 "profit_rate":2.5,		//盈利率
 "recommend_count":23, //推荐数
 "win_rate":39,			//胜率
 "winnum":9			//赢盘数
 },
 "goodsclass":{			//擅长赛事对象
 "gonum":1,		//走水数
 "losenum":1,		//输盘数
 "profit_rate":63.7,	//盈利率
 "recommend_count":4,	//推荐数
 "sclasscolor":"#009900", //赛事颜色
 "sclassid":25,		//赛事编号
 "sclassname":"日职联",	//赛事名称
 "win_rate":67, 		//胜率
 "winnum":2		//赢盘数
 },
 "id":1281,			//用户id
 "level_id":1,		//用户等级
 "losenum":19,		//用户总输盘数
 "nearten":["赢","输","赢","输","赢","赢","输","输","输","赢"],	//近10场推荐
 "news":{...},		//和推荐属性一样
 "nickname":"小猪联合登录",	//用户昵称
 "pic":"http://q.qlogo.cn/qqapp/11F44F535A/100",	//用户头像
 "profit_rate":-1.7, 	//用户总盈利率
 "recommend_count":0, //用户总推荐数
 "role_id":1,		//角色id
 "totalrate":[{		//近6个月盈利率走势图(6条数据)
 "date":"2016-8",	//y轴时间
 "gonum":0,		//走水数
 "losenum":3,		//输盘数
 "profit_rate":64.2,	//盈利率
 "recommend_count":7,	//推荐数
 "win_rate":57,		//胜率
 "winnum":4		//赢盘数
 },......}
 ],
 "userinfo":"本大三！牛逼不吹大，实力来说话。",	//简介
 "usertitle":["奖牌地址"],	//用户头衔
 "win_rate":39,		//用户总胜率
 "winnum":12		//用户总赢盘数
 }
 

 */
#import "BasicModel.h"
#import "GoodPlayModel.h"
#import "GoodsclassModel.h"
#import "TuijiandatingModel.h"
#import "TotalrateModel.h"
@interface StatisticsModel : BasicModel
@property (nonatomic, assign) NSInteger avgweeknum;
@property (nonatomic, assign) NSInteger focus_count;
@property (nonatomic, assign) NSInteger follower_count;
@property (nonatomic, assign) NSInteger gonum;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger level_id;
@property (nonatomic, assign) NSInteger losenum;
@property (nonatomic, assign) NSInteger recommend_count;
@property (nonatomic, assign) NSInteger role_id;
@property (nonatomic, assign) NSInteger winnum;
//用户信息
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *userinfo;
@property (nonatomic, copy) NSString *usertitle;

@property (nonatomic, copy) NSString *profit_rate;
@property (nonatomic, copy) NSString *win_rate;

@property (nonatomic, strong) GoodPlayModel *goodPlay;
@property (nonatomic, strong) GoodsclassModel *goodsclass;
//单场
@property (nonatomic, strong) TuijiandatingModel *Recoommandmodel;



@property (nonatomic, strong) NSArray *arrNearten;
@property (nonatomic, strong) NSArray *arrTotalrate;

//"7中5"
@property (nonatomic, strong) NSArray *arrUsertitle;
//头衔，图片
@property (nonatomic, strong) NSArray *medals;


@end
