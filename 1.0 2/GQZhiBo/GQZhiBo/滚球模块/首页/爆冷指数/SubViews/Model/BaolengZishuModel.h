//
//  BaolengZishuModel.h
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface BaolengZishuModel : BasicModel
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString *sortone;

@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger teamid;
@property (nonatomic, strong) NSString *teamname;
@property (nonatomic, assign) NSTimeInterval mtime;
@property (nonatomic, strong) NSString *league;
@property (nonatomic, strong) NSString *hometeam;
@property (nonatomic, strong) NSString *guestteam;
@property (nonatomic, assign) NSInteger mostresult;
@property (nonatomic, strong) NSString *win;
@property (nonatomic, strong) NSString *draw;
@property (nonatomic, strong) NSString *lose;
@property (nonatomic, assign) NSInteger historyresult;
@property (nonatomic, assign) NSInteger num;

@end
