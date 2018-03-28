//
//  PanwangCollectCell.m
//  GQapp
//
//  Created by WQ on 2017/8/23.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "PanwangCollectCell.h"
#import "PanwangZhishuTable.h"
@interface PanwangCollectCell()
@property (nonatomic, strong) PanwangZhishuTable *table;
@end
@implementation PanwangCollectCell

- (void)setType:(NSString *)type
{
    _type = type;

    [self.contentView addSubview:self.table];
    _table.type = _type;

    
}

- (PanwangZhishuTable *)table
{
    if (!_table) {
        _table = [[PanwangZhishuTable alloc] initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _table;
}


@end
