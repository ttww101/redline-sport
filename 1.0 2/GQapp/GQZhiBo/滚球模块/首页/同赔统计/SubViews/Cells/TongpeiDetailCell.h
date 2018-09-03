//
//  TongpeiDetailCell.h
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TongPeiMatchModel.h"
@interface TongpeiDetailCell : UITableViewCell
@property (nonatomic, strong) TongPeiMatchModel *model;
//1：亚盘   2大小球  0胜平负
@property (nonatomic, assign) NSInteger pelvIndex;

@end
