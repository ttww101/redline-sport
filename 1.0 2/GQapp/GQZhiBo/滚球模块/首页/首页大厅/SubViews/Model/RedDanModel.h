//
//  RedDanModel.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/7/5.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface RedDanModel : BasicModel
@property (nonatomic, assign)NSInteger scheduleId;
@property (nonatomic, retain)NSString *homeTeam;
@property (nonatomic, retain)NSString *guestTeamId;
@property (nonatomic, retain)NSString *choice;
@property (nonatomic, assign)NSInteger homescore;
@property (nonatomic, assign)NSInteger newsId;
@property (nonatomic, retain)NSString *pic;
@property (nonatomic, retain)NSString *winRate;
@property (nonatomic, assign)NSInteger userId;
@property (nonatomic, assign)NSInteger guestscore;
@property (nonatomic, retain)NSString *nickName;
@property (nonatomic, retain)NSString *matchTime;
@property (nonatomic, retain)NSString *guestTeam;
@property (nonatomic, retain)NSString *play;
@property (nonatomic, retain)NSString *homeTeamId;
@property (nonatomic, retain)NSArray *usermark;
@property (nonatomic, assign)NSInteger result;



@end
