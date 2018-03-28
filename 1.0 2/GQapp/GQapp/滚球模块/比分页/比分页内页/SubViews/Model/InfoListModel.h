//
//  InfoListModel.h
//  GunQiuLive
//
//  Created by WQ_h on 16/3/14.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "BasicModel.h"

@interface InfoListModel : BasicModel
@property (nonatomic, copy) NSString *GuestTeam;
@property (nonatomic, copy) NSString *Name_JS;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *HomeTeam;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, assign) NSInteger create_timeInterval;
@property (nonatomic, copy) NSString *MatchTime;
@property (nonatomic, copy) NSString *lotterySort;
@property (nonatomic, copy) NSString *ya;
@property (nonatomic, copy) NSString *spf;
@property (nonatomic, copy) NSString *dx;
@property (nonatomic, assign) int comment_count;
@property (nonatomic, assign) int choice;
@property (nonatomic, copy) NSString *fans;
@property (nonatomic, copy) NSString *win_rate;
@property (nonatomic, assign) int share_count;
@property (nonatomic, assign) int match_id;
@property (nonatomic, assign) int share_weixin_count;
@property (nonatomic, assign) int share_weibo_count;
@property (nonatomic, assign) int idId;
@property (nonatomic, copy) NSString *profit_rate;
//场数
@property (nonatomic, copy) NSString *recommend_count;
@property (nonatomic, copy) NSString *info_count;

@property (nonatomic, assign) int like_count;
@property (nonatomic, assign) int hate_count;

@property (nonatomic, assign) int user_id;
//粉丝数
@property (nonatomic, assign) NSInteger follower_count;
@property (nonatomic, assign) NSInteger focus_count;
@property (nonatomic, assign) BOOL focused;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic, assign) BOOL hated;
@property (nonatomic, copy) NSString *result;
@property (nonatomic, assign) NSInteger MatchState;
@property (nonatomic, copy) NSString *GuestScore;
@property (nonatomic, copy) NSString *HomeScore;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *multiple;
//头像右边的头衔
@property (nonatomic, copy) NSString *usertitle;
// 球队id
@property (nonatomic, assign) NSInteger GuestTeamID;
@property (nonatomic, assign) NSInteger HomeTeamID;
//头衔
@property (nonatomic, strong) NSArray *medals;
@property (nonatomic, strong)NSString *newsTypeName;
@property (nonatomic, strong)NSString *newsTypeColor;
@property (nonatomic, assign)NSInteger mark;

@end
