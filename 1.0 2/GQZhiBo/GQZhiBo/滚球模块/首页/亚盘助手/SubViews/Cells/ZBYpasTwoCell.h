//
//  ZBYpasTwoCell.h
//  GQapp
//
//  Created by WQ on 2017/10/12.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBPlycModel.h"

@interface ZBYpasTwoCell : UITableViewCell
@property (nonatomic, strong) ZBPlycModel *model;
//0亚盘助手  1 大小球盘口
@property (nonatomic, assign) NSInteger typeOdd;

@end
