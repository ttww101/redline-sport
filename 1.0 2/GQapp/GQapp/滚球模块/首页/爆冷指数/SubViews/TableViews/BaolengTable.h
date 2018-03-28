//
//  BaolengTable.h
//  GQapp
//
//  Created by WQ on 2017/8/31.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicTableView.h"

@interface BaolengTable : BasicTableView
//0 全部  1 热门  2竞彩  3北单

- (void)updateWithType:(NSInteger)type;

@end
