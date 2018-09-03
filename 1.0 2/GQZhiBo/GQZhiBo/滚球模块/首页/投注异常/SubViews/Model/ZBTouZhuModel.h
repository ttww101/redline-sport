//
//  ZBTouZhuModel.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/22.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"

@interface ZBTouZhuModel : ZBBasicModel

@property (nonatomic, assign)NSInteger sid;//比赛id
@property (nonatomic, retain)NSString *sort;//竞彩编号
@property (nonatomic, retain)NSString *league;//联赛名称
@property (nonatomic, retain)NSString *mtime;////开赛时间
@property (nonatomic, assign)NSInteger type;//0:负 1:平  3:胜

@property (nonatomic, retain)NSDictionary *bifa;
@property (nonatomic, retain)NSDictionary *deal;

@property (nonatomic, retain)NSString *maxval;//最大值
@property (nonatomic, retain)NSString *hometeam;
@property (nonatomic, retain)NSString *guestteam;
@property (nonatomic, assign)NSInteger homescore;
@property (nonatomic, assign)NSInteger guestscore;
@property (nonatomic, assign)NSInteger matchstate;

@end
