//
//  ZBYpasCell.h
//  GQapp
//
//  Created by WQ on 2017/9/28.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBPlycModel.h"
@interface ZBYpasCell : UITableViewCell
@property (nonatomic, strong) ZBPlycModel *model;
//0亚盘助手  1 大小球盘口
@property (nonatomic, assign) NSInteger typeOdd;

@end
