//
//  ZBTuijianDatingCell.h
//  GQapp
//
//  Created by WQ_h on 16/8/2.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBUserViewOfTuijianCellCopy.h"
#import "ZBTuijiandatingModel.h"

@interface ZBTuijianDatingCell : UITableViewCell
@property (nonatomic, strong) ZBTuijiandatingModel *model;
@property (nonatomic, assign) typeTuijianCell type;
@end
