//
//  ZBNewQingBaoCell.h
//  GQapp
//
//  Created by 叶忠阳 on 16/10/28.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBQingBaoFPTwoModel.h"

@interface ZBNewQingBaoCell : UITableViewCell

@property (nonatomic, strong)ZBQingBaoFPTwoModel *model;

@property (nonatomic, strong)NSString *strQiCi;

@property (nonatomic, assign)NSInteger newType;

@end
