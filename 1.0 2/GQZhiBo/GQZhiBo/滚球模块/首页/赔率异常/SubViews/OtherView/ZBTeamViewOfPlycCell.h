//
//  ZBTeamViewOfPlycCell.h
//  GQapp
//
//  Created by WQ on 2017/9/28.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBPlycModel.h"
@interface ZBTeamViewOfPlycCell : UIView
//1 赔率异常  2亚盘监控  3水位监控
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) ZBPlycModel *model;
@end
