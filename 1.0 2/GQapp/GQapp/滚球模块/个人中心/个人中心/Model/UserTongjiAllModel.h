//
//  UserTongjiAllModel.h
//  GQapp
//
//  Created by WQ on 2017/8/22.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"
#import "UserTongjiModel.h"
@interface UserTongjiAllModel : BasicModel
@property (nonatomic, strong) UserTongjiModel *month;
@property (nonatomic, strong) UserTongjiModel *all;
@property (nonatomic, strong) UserTongjiModel *week;
@property (nonatomic, strong) NSArray *recent;
@end
