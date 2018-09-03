//
//  ZBRelRecNewVC.h
//  GQapp
//
//  Created by WQ on 16/11/17.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicViewController.h"
#import "ZBDan_StringMatchsModel.h"

@interface ZBRelRecNewVC : ZBBasicViewController

@property (nonatomic, strong)ZBDan_StringMatchsModel *model;
@property (nonatomic, assign)NSInteger newTypeNum;//选择的玩法
@property (nonatomic, assign)NSInteger oddsNum;//选择的赔率3,1,0


@end
