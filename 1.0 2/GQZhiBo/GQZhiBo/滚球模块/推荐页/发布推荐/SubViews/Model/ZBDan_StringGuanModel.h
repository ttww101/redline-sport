//
//  ZBDan_StringGuanModel.h
//  GQapp
//
//  Created by 叶忠阳 on 16/9/5.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"
#import "ZBDan_StringMatchsModel.h"

@interface ZBDan_StringGuanModel : ZBBasicModel

@property (nonatomic, assign)NSInteger count;
@property (nonatomic, retain)NSString *index;//联赛名称
@property (nonatomic, retain)NSMutableArray *matchs;


@end
