//
//  NullTableViewCell.h
//  newGQapp
//
//  Created by genglei on 2018/3/30.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NullTableViewCell : UITableViewCell

+ (NullTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;

@end
