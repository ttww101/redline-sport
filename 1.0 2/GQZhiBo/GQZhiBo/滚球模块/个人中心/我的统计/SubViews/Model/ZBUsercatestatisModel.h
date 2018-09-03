//
//  ZBUsercatestatisModel.h
//  GQapp
//
//  Created by WQ on 2017/1/9.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"
#import "ZBStatisticsModel.h"
#import "ZBGoodPlayModel.h"
#import "ZBGoodsclassModel.h"
#import "ZBTotalrateModel.h"
#import "ZBStatisticsSectionTwoModel.h"
@interface ZBUsercatestatisModel : ZBBasicModel
//每周推荐的总数
@property (nonatomic, assign) NSInteger avgweeknum;

//里面包含盈利率内容
@property (nonatomic, strong) ZBStatisticsModel *userinfo;
@property (nonatomic, strong) ZBGoodPlayModel *goodplay;
@property (nonatomic, strong) ZBGoodsclassModel *goodsclass;
//折线图
@property (nonatomic, strong) NSArray *totalrate;
@property (nonatomic, strong) NSArray *nearten;

//赛事统计
@property (nonatomic, strong) NSArray *sclassStatis;
//玩法统计
@property (nonatomic, strong) NSArray *playStatis0;


//胜平负统计
@property (nonatomic, strong) NSArray *playStatis1;
//胜平负赔率统计（欧赔）
@property (nonatomic, strong) NSArray *ouPanStatis;

//亚盘统计
@property (nonatomic, strong) NSArray *playStatis2;
//亚盘盘口统计（让球）
@property (nonatomic, strong) NSArray *yaPanStatis;


//大小球统计
@property (nonatomic, strong) NSArray *playStatis3;
//大小球盘口统计
@property (nonatomic, strong) NSArray *dxPanStatis;


//时间统计
@property (nonatomic, strong) NSArray *timeStatis;
//月赛事统计
@property (nonatomic, strong) NSArray *monthGroup;
//每日赛事统计
@property (nonatomic, strong) NSArray *weekGroup;

@end
