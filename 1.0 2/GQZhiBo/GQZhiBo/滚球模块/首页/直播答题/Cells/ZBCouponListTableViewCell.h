//
//  ZBCouponListTableViewCell.h
//  newGQapp
//
//  Created by genglei on 2018/4/13.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBCouponModel.h"

@interface ZBCouponListTableViewCell : UITableViewCell

+ (ZBCouponListTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;

- (void)refreshContentData:(id)model;


@end
