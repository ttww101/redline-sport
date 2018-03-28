//
//  TotalrateModel.h
//  GQapp
//
//  Created by WQ_h on 16/8/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface TotalrateModel : BasicModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *unitstr;

@property (nonatomic, copy) NSString *profitRate;
@property (nonatomic, copy) NSString *winRate;
@property (nonatomic, assign) NSInteger gonum;
@property (nonatomic, assign) NSInteger losenum;
@property (nonatomic, assign) NSInteger recommendCount;
@property (nonatomic, assign) NSInteger winnum;

@end
