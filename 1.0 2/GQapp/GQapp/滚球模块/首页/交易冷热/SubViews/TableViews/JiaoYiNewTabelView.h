//
//  JiaoYiNewTabelView.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/20.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicTableView.h"

@interface JiaoYiNewTabelView : BasicTableView
//3 总交易量  1庄家盈利  2庄家盈亏

- (void)updateWithType:(NSInteger)type;

@end
