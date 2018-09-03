//
//  ZBliveLineupModel.h
//  GQapp
//
//  Created by WQ_h on 16/5/4.
//  Copyright © 2016年 GQXX. All rights reserved.
//
/*
 goals：进球数，name：球员名称，assist：助攻数，rounds：出场次数，bestsum：最佳次数，rating：评分，place：球员位置，type：1、前场，2、中场，3、后场
 */
#import "ZBBasicModel.h"

@interface ZBliveLineupModel : ZBBasicModel
@property (nonatomic, copy) NSString *goals;
@property (nonatomic, copy) NSString *teamid;
@property (nonatomic, copy) NSString *assist;
@property (nonatomic, copy) NSString *rounds;
@property (nonatomic, copy) NSString *playerid;
@property (nonatomic, copy) NSString *bestsum;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *place;
@end
