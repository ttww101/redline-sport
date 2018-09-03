//
//  GQMineTableViewCell.h
//  newGQapp
//
//  Created by genglei on 2018/4/27.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQMineModel.h"

@interface GQMineTableViewCell : UITableViewCell

+ (GQMineTableViewCell *)cellForTableView:(UITableView *)tableView;

+ (CGFloat)heightForCell;

- (void)refreshContentData:(GQMineModel *)model;


@end
