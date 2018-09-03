//
//  TongpeiDetailModel.h
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"
#import "TongPeiMatchModel.h"
@interface TongpeiDetailModel : BasicModel
@property (nonatomic, assign) NSInteger playType;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *win;
@property (nonatomic, strong) NSString *draw;
@property (nonatomic, strong) NSString *lose;
@property (nonatomic, assign) NSInteger matchNum;
@property (nonatomic, strong) NSString *winRate;
@property (nonatomic, strong) NSString *drawRate;
@property (nonatomic, strong) NSString *loseRate;
@property (nonatomic, strong) NSString *winRateDesc;
@property (nonatomic, strong) NSString *drawRateDesc;
@property (nonatomic, strong) NSString *loseRateDesc;
@property (nonatomic, strong) NSArray *matchs;

@property (nonatomic, strong) NSString *homeTeam;
@property (nonatomic, strong) NSString *guestTeam;

@end
