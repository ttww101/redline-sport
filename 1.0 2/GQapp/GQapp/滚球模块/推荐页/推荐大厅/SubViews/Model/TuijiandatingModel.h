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
@property (nonatomic, copy) NSString *Name_JS;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *userinfo;

@property (nonatomic, copy) NSString *HomeTeam;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *contentInfo;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSTimeInterval create_time;
@property (nonatomic, copy) NSString *MatchTime;
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
//场数
@property (nonatomic, assign) NSInteger recommend_count;
@property (nonatomic, assign) NSInteger info_count;

@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, assign) NSInteger payUsers_count;
@property (nonatomic, strong) NSDictionary *payUsers;
@property (nonatomic, assign) NSInteger hate_count;

@property (nonatomic, assign) NSInteger user_id;
//粉丝数
@property (nonatomic, assign) NSInteger follower_count;
@property (nonatomic, assign) NSInteger focus_count;
@property (nonatomic, assign) BOOL focused;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic, assign) BOOL hated;
@property (nonatomic, assign) BOOL see;

@property (nonatomic, copy) NSString *result;
@property (nonatomic, assign) NSInteger MatchState;
@property (nonatomic, assign) NSInteger GuestScore;
@property (nonatomic, assign) NSInteger HomeScore;
@property (nonatomic, copy) NSString *company;

@property (nonatomic, assign) NSInteger multiple;
//头像右边的头衔
@property (nonatomic, copy) NSString *usertitle;
// 球队id
@property (nonatomic, assign) NSInteger GuestTeamID;
@property (nonatomic, assign) NSInteger HomeTeamID;
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
@end
