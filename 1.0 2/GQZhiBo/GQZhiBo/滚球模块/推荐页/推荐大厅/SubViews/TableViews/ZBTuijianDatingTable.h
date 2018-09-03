//
//  ZBTuijianDatingTable.h
//  GQapp
//
//  Created by WQ on 2017/8/24.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicTableView.h"

@interface ZBTuijianDatingTable : ZBBasicTableView
@property (nonatomic, assign) NSInteger playType;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style playType:(NSInteger)type;

- (void)addSelectedView;
@end
