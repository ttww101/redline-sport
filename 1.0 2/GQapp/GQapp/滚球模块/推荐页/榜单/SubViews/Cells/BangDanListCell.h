//
//  BangDanListCell.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/4/28.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommandListModel.h"

@interface BangDanListCell : UITableViewCell

@property (nonatomic, assign)NSInteger cellNum;//cell的row
@property (nonatomic, strong)RecommandListModel  *model;
@property (nonatomic, assign)NSInteger type;//判断是那个榜单
@end
