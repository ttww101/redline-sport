//
//  HeaderTableViewCell.h
//  newGQapp
//
//  Created by genglei on 2018/7/18.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTableViewCell : UITableViewCell

@property (nonatomic , copy) NSString *title;

+ (HeaderTableViewCell *)cellForTableView:(UITableView *)tableView;

+ (CGFloat)heightForCell;

@end
