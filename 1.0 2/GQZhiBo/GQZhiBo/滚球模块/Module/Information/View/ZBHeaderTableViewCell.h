//
//  ZBHeaderTableViewCell.h
//  newGQapp
//
//  Created by genglei on 2018/7/18.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBHeaderTableViewCell : UITableViewCell

@property (nonatomic , copy) NSString *title;

+ (ZBHeaderTableViewCell *)cellForTableView:(UITableView *)tableView;

+ (CGFloat)heightForCell;

@end
