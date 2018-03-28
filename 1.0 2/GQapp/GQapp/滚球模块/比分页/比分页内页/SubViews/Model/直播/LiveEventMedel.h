//
//  LiveEventMedel.h
//  GQapp
//
//  Created by WQ_h on 16/5/4.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface LiveEventMedel : BasicModel
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger teamid;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger ishome;
//区分是第一个cell 还是最后一个cell 0 中间的cell  1：第一个cell 2：最后一个cell
@property (nonatomic, assign) NSInteger headerOrFooter;

@end
