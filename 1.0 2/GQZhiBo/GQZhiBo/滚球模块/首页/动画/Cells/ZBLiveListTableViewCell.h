//
//  ZBLiveListTableViewCell.h
//  newGQapp
//
//  Created by genglei on 2018/4/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBLiveListModel.h"

@interface ZBLiveListTableViewCell : UITableViewCell

+ (ZBLiveListTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;

- (void)refreshContentData:(ZBLiveListModel *)model;


@end
