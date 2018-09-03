//
//  SaishiSelecterdVC.h
//  GQapp
//
//  Created by WQ_h on 16/8/25.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ViewPagerController.h"
#import "SelectedAllVC.h"
#import "SelectedJincaiVC.h"
#import "SelectedChupanVC.h"
#import "BasicViewController.h"

@interface SaishiSelecterdVC : ViewPagerController
//全部赛事的数据
@property (nonatomic, strong) NSArray *arrData;
//竞彩赛事的数据
@property (nonatomic, strong) NSArray *arrDataJingcai;
//初盘赛事的数据
@property (nonatomic, strong) NSArray *arrDataChupan;

@property (nonatomic, assign)NSInteger jincai;//竞猜里面的筛选 为 1
//区分是从哪个页面跳进来进行筛选
@property (nonatomic) typeSaishiSelecterdVC type;
//比赛的数据
@property (nonatomic, strong) NSArray *arrBifenData;

//比赛的数据
@property (nonatomic, strong) NSArray *arrTuijianSelectedData;

//比赛的数据
@property (nonatomic, strong) NSArray *arrInfoSelectedData;



@end
