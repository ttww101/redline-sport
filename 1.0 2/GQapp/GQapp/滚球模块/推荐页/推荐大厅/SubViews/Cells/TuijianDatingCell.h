//
//  TuijianDatingCell.h
//  GQapp
//
//  Created by WQ_h on 16/8/2.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserViewOfTuijianCell.h"
#import "TuijiandatingModel.h"

@interface TuijianDatingCell : UITableViewCell
@property (nonatomic, strong) TuijiandatingModel *model;
@property (nonatomic, assign) typeTuijianCell type;
@end
