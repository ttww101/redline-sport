//
//  ZBUserTongjiCell.h
//  GQapp
//
//  Created by WQ on 2017/8/18.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBUserTongjiAllModel.h"
@protocol UserTongjiCellDelegate<NSObject>
@optional
- (void)didToTongjiVC;
@end
@interface ZBUserTongjiCell : UITableViewCell
@property (nonatomic, strong) ZBUserTongjiAllModel *model;
@property (nonatomic, weak) id<UserTongjiCellDelegate> delegate;
@property(nonatomic,assign)NSInteger Number;
@end
