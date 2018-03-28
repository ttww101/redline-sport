//
//  PanwangCell.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanWangModel.h"

@interface PanwangCell : UITableViewCell
@property (nonatomic, strong)UILabel *labGaiLv;//概率
@property (nonatomic, strong)UILabel *labGaiLvTitle;//概率

@property (nonatomic, assign)NSInteger rankNum;
@property (nonatomic, strong)PanWangModel *model;

@end
