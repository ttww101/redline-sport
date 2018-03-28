//
//  YpasTwoCell.h
//  GQapp
//
//  Created by WQ on 2017/10/12.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlycModel.h"

@interface YpasTwoCell : UITableViewCell
@property (nonatomic, strong) PlycModel *model;
//0亚盘助手  1 大小球盘口
@property (nonatomic, assign) NSInteger typeOdd;

@end
