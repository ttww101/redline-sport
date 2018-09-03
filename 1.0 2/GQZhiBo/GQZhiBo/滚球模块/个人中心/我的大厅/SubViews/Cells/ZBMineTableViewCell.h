//
//  ZBMineTableViewCell.h
//  newGQapp
//
//  Created by genglei on 2018/4/27.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBMineModel.h"

@interface ZBMineTableViewCell : UITableViewCell

+ (ZBMineTableViewCell *)cellForTableView:(UITableView *)tableView;

+ (CGFloat)heightForCell;

- (void)refreshContentData:(ZBMineModel *)model;


@end
