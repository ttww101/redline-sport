//
//  BisaiTongjiCell.h
//  GQapp
//
//  Created by WQ on 2017/8/14.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveEventMedel.h"
@interface BisaiTongjiCell : UITableViewCell
@property (nonatomic, strong) LiveEventMedel *model;
-(void)tongjimmodel:(LiveEventMedel*)model;
@end
