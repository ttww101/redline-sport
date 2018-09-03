//
//  ZBBisaiTongjiCell.h
//  GQapp
//
//  Created by WQ on 2017/8/14.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBLiveEventMedel.h"
@interface ZBBisaiTongjiCell : UITableViewCell
@property (nonatomic, strong) ZBLiveEventMedel *model;
-(void)tongjimmodel:(ZBLiveEventMedel*)model;
@end
