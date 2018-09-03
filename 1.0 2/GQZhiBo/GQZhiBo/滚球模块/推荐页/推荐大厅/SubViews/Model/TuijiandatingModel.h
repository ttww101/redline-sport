//
//  TuijiandatingModel.h
//  GQapp
//
//  Created by WQ_h on 16/8/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface TuijiandatingModel : BasicModel




@property (nonatomic, copy) NSString *GuestTeam;
@property (nonatomic, copy) NSString *guestTeam;

@property (nonatomic , copy) NSString *leagueName;
@property (nonatomic, copy) NSString *Name_JS;

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *userinfo;

@property (nonatomic, copy) NSString *HomeTeam;
@property (nonatomic, copy) NSString *homeTeam;

@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *contentInfo;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSTimeInterval create_time;
@property (nonatomic, copy) NSString *MatchTime;
@property (nonatomic , copy) NSString *matchTime;
@property (nonatomic, copy) NSString *lotterySort;
@property (nonatomic, strong) NSArray *ya;

@property (nonatomic, strong) NSArray *spf;
@property (nonatomic, strong) NSArray *dx;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger pay_count;
@property (nonatomic, assign) NSInteger choice;
@property (nonatomic, assign) NSInteger fans;
@property (nonatomic, copy) NSString *win_rate;
@property (nonatomic, copy) NSString *profit_rate;

@property (nonatomic, assign) NSInteger share_count;
@property (nonatomic, assign) NSInteger match_id;
@property (nonatomic, assign) NSInteger share_weixin_count;
@property (nonatomic, assign) NSInteger share_weibo_count;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic , assign) NSInteger newsId;
//场数
@property (nonatomic, assign) NSInteger recommend_count;
@property (nonatomic, assign) NSInteger info_count;

@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, assign) NSInteger payUsers_count;
@property (nonatomic, strong) NSDictionary *payUsers;
@property (nonatomic, assign) NSInteger hate_count;

@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger userId;

//粉丝数
@property (nonatomic, assign) NSInteger follower_count;
@property (nonatomic, assign) NSInteger focus_count;
@property (nonatomic, assign) BOOL focused;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic, assign) BOOL hated;
@property (nonatomic, assign) BOOL see;
@property (nonatomic, assign) BOOL canSee;


@property (nonatomic, copy) NSString *result;
@property (nonatomic , copy) NSString *recommendResult;
@property (nonatomic, assign) NSInteger MatchState;
@property (nonatomic, assign) NSInteger matchState;
@property (nonatomic, assign) NSInteger GuestScore;
@property (nonatomic, assign) NSInteger guestScore;
@property (nonatomic, assign) NSInteger HomeScore;
@property (nonatomic, assign) NSInteger homeScore;
@property (nonatomic, copy) NSString *company;

@property (nonatomic, assign) NSInteger multiple;
//头像右边的头衔
@property (nonatomic, copy) NSString *usertitle;
// 球队id
@property (nonatomic, assign) NSInteger GuestTeamID;
@property (nonatomic, assign) NSInteger guestTeamID;
@property (nonatomic, assign) NSInteger HomeTeamID;
@property (nonatomic, assign) NSInteger homeTeamID;
@property (nonatomic, assign) NSInteger earn;

@property (nonatomic, strong) NSArray *arrUsermark;
//头衔
@property (nonatomic, strong) NSArray *medals;
//联赛颜色
@property (nonatomic, strong) NSString *leagueColor;
//阅读数
@property (nonatomic, assign) NSInteger readCount;
//近7/30天描述
@property (nonatomic, strong) NSString *dayRange;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) NSInteger oid;
@property (nonatomic, strong) NSString *paytime;
@property (nonatomic, strong) NSString *paystatus;
@property (nonatomic, assign) NSInteger status;

//竞猜返回的类型和赔率
@property (nonatomic, assign) NSInteger playtype;
@property (nonatomic, strong) NSString *pay_time;

@property (nonatomic, strong) NSArray *odds;
//1是推荐 2 是竞猜
@property (nonatomic, assign) NSInteger otype;

// 等级
@property (nonatomic , copy) NSString *levelName;

@property (nonatomic , copy) NSString *remark;

@property (nonatomic , copy) NSString *goodSclass;

@property (nonatomic , copy) NSString *sclassWinRate;

@property (nonatomic , copy) NSString *playWinRate;

@property (nonatomic , assign) NSInteger goodPlay;

@property (nonatomic , assign) NSInteger playType;

@property (nonatomic , copy) NSString *recommendTime;

@property (nonatomic , copy) NSString *buyCount; // 购买人数

@property (nonatomic, assign) BOOL showPrice; // 是否显示金币

@property (nonatomic, assign) BOOL showBuyCount; // 是否显示购买人数

@end
