//
//  JiXianCell.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record_OneModel.h"
@interface JiXianCell : UITableViewCell

@property (nonatomic, assign)NSInteger type;
@property (nonatomic, strong)Record_OneModel *model;

@end
