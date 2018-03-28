//
//  RemindModel.h
//  GQapp
//
//  Created by WQ on 16/10/10.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface RemindModel : BasicModel
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *mtime;
@property (nonatomic, strong) NSString *league;
@property (nonatomic, strong) NSString *hometeam;
@property (nonatomic, strong) NSString *guestteam;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) NSInteger newsid;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL iread;

@end
