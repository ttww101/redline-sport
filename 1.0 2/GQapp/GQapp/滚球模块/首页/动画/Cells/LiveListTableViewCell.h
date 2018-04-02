//
//  LiveListTableViewCell.h
//  newGQapp
//
//  Created by genglei on 2018/4/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListModel.h"

@interface LiveListTableViewCell : UITableViewCell

+ (LiveListTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;

- (void)refreshContentData:(LiveListModel *)model;


@end
