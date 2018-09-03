//
//  ZBUserTongjiAllModel.h
//  GQapp
//
//  Created by WQ on 2017/8/22.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"
#import "ZBUserTongjiModel.h"
@interface ZBUserTongjiAllModel : ZBBasicModel
@property (nonatomic, strong) ZBUserTongjiModel *month;
@property (nonatomic, strong) ZBUserTongjiModel *all;
@property (nonatomic, strong) ZBUserTongjiModel *week;
@property (nonatomic, strong) NSArray *recent;
@end
