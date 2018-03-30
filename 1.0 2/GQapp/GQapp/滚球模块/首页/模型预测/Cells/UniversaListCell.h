//
//  UniversaListCell.h
//  newGQapp
//
//  Created by genglei on 2018/3/30.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UniversaListCellModel : NSObject

@property (nonatomic , copy) NSString *leftIconImageName;

@property (nonatomic , copy) NSString *content;

@property (nonatomic , assign) NSInteger index;

@end

@interface UniversaListCell : UITableViewCell

+ (UniversaListCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;

- (void)refreshContentData:(UniversaListCellModel *)model;

@end
