//
//  UserTongjiCell.h
//  GQapp
//
//  Created by WQ on 2017/8/18.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserTongjiAllModel.h"
@protocol UserTongjiCellDelegate<NSObject>
@optional
- (void)didToTongjiVC;
@end
@interface UserTongjiCell : UITableViewCell
@property (nonatomic, strong) UserTongjiAllModel *model;
@property (nonatomic, weak) id<UserTongjiCellDelegate> delegate;
@property(nonatomic,assign)NSInteger Number;
@end
