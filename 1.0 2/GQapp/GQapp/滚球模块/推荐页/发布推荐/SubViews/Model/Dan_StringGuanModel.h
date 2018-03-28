//
//  Dan_StringGuanModel.h
//  GQapp
//
//  Created by 叶忠阳 on 16/9/5.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"
#import "Dan_StringMatchsModel.h"

@interface Dan_StringGuanModel : BasicModel

@property (nonatomic, assign)NSInteger count;
@property (nonatomic, retain)NSString *index;//联赛名称
@property (nonatomic, retain)NSMutableArray *matchs;


@end
