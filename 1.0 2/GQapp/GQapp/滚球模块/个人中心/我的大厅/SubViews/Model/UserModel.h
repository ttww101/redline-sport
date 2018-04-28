//
//  UserModel.h
//  GQapp
//
//  Created by WQ_h on 16/3/29.
//  strongright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface UserModel : BasicModel
@property (nonatomic, strong) NSString *cnickid;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *showmobile;

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) BOOL avaliable;
@property (nonatomic, assign) NSInteger extension1;
@property (nonatomic, assign) NSInteger focusCount;
@property (nonatomic, assign) NSInteger followerCount;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger infoCount;
@property (nonatomic, assign) NSInteger levelId;
@property (nonatomic, assign) NSInteger profitRate;
@property (nonatomic, assign) NSInteger recommendCount;
@property (nonatomic, assign) NSInteger resource;
@property (nonatomic, assign) NSInteger roleId;
@property (nonatomic, assign) NSInteger winRate;
@property (nonatomic, assign) BOOL focused;
@property (nonatomic, strong) NSString *userinfo;
@property (nonatomic, strong) NSString *usertitle;
@property (nonatomic, assign)NSInteger mode;
//头衔
@property (nonatomic, strong) NSArray *medals;

@property (nonatomic, assign)NSInteger analyst;
@property (nonatomic, assign)NSInteger autonym;
@property (nonatomic, strong)NSString *qq;
@property (nonatomic, strong)NSString *wechat;
@property (nonatomic, strong)NSString *applyreason;
@property (nonatomic, strong)NSString *realname;
@property (nonatomic, strong)NSString *cardid;
@property (nonatomic, strong)NSString *skill;
@property (nonatomic, strong)NSString *failreason;
//几连红
@property (nonatomic, strong)NSString *remarkContinuous;
//几种几
@property (nonatomic, strong)NSString *remarkWinNum;
@property (nonatomic, strong)NSString *token;
@property (nonatomic, strong)NSString *refreshToken;
//分析师球币
@property (nonatomic, assign)NSInteger balance;
//是否达到每日推荐上限
@property (nonatomic, assign) BOOL reachLimit;

// 金币数量
@property (nonatomic , copy) NSNumber *coin;

@end
