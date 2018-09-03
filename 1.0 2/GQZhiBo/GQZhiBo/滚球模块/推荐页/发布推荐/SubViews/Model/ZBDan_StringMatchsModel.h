//
//  ZBDan_StringMatchsModel.h
//  GQapp
//
//  Created by 叶忠阳 on 16/9/5.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"
#import "ZBDxModel.h"
#import "ZBPriceListModel.h"
@interface ZBDan_StringMatchsModel : ZBBasicModel

@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, strong)NSString *hometeam;
@property (nonatomic, strong)NSString *guestteam;
@property (nonatomic, assign)NSInteger guestteamid;
@property (nonatomic, assign)NSInteger hometeamid;
@property (nonatomic, strong)NSString *league;
@property (nonatomic, strong)NSString *leagueColor;
@property (nonatomic, assign)NSInteger leagueId;
@property (nonatomic, strong)NSString *matchtime;
@property (nonatomic, strong)NSString *matchstate;
@property (nonatomic, strong)NSString *sort;
@property (nonatomic, strong)NSString *spf1;
@property (nonatomic, strong)NSString *spf2;
@property (nonatomic, strong)NSString *spf3;
@property (nonatomic, strong)NSString *dx1;
@property (nonatomic, strong)NSString *dx2;
@property (nonatomic, strong)NSString *dx3;
@property (nonatomic, strong)NSString *rq1;
@property (nonatomic, strong)NSString *rq2;
@property (nonatomic, strong)NSString *rq3;
@property (nonatomic, strong)NSString *rqodds;
@property (nonatomic, strong)NSString *dxodds;
@property (nonatomic, strong)NSString *dxcompany;
@property (nonatomic, strong)NSString *rqcompany;
@property (nonatomic, strong)NSString *spfcompany;

@property (nonatomic, strong)NSArray *spf;
@property (nonatomic, strong)NSArray *rq;
@property (nonatomic, strong)NSArray *dx;
@property (nonatomic, strong) NSArray *priceList;
@end
