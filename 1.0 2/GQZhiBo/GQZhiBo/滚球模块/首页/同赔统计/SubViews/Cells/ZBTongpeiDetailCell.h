//
//  ZBTongpeiDetailCell.h
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBTongPeiMatchModel.h"
@interface ZBTongpeiDetailCell : UITableViewCell
@property (nonatomic, strong) ZBTongPeiMatchModel *model;
//1：亚盘   2大小球  0胜平负
@property (nonatomic, assign) NSInteger pelvIndex;

@end
