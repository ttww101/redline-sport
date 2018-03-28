//
//  NewQBTableViewCell.h
//  GQapp
//
//  Created by WQ_h on 16/5/9.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoListModel.h"
@interface NewQBTableViewCell : UITableViewCell
@property (nonatomic, strong) InfoListModel *model;
// 显示底部的横线
@property (nonatomic, assign) BOOL hideBottomView;
@end
