//
//  MostModel.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/7/6.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface MostModel : BasicModel
@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, retain)NSString *league;
@property (nonatomic, retain)NSString *hometeam;
@property (nonatomic, retain)NSString *guestteam;
@property (nonatomic, assign)NSInteger hometeamid;
@property (nonatomic, assign)NSInteger guestteamid;
@property (nonatomic, retain)NSString *teamname;
@property (nonatomic, retain)NSString *mark;
@property (nonatomic, assign)NSInteger historymostresult;
@property (nonatomic, assign)NSInteger mostresult;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, retain)NSString *sort;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *maxname;

@end
