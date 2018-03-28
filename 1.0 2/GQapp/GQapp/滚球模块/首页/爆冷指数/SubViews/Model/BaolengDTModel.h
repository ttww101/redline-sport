//
//  BaolengDTModel.h
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"
@interface BaolengDTModel : BasicModel
@property (nonatomic, strong) NSString *teamname;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSTimeInterval mtime;
@property (nonatomic, assign) NSInteger sid;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger mostresult;
@property (nonatomic, assign) NSInteger historyresult;
@property (nonatomic, assign) NSInteger anotherteamid;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, assign) NSInteger statistime;
@property (nonatomic, assign) NSInteger teamid;
@property (nonatomic, strong) NSString *guestteam;
@property (nonatomic, strong) NSString *hometeam;

@end
