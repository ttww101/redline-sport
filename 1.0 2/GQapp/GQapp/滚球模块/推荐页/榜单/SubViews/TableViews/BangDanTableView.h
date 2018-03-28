//
//  BangDanTableView.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/4/28.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicTableView.h"



@interface BangDanTableView : BasicTableView
@property (nonatomic, assign)NSInteger typeNum;
@property (nonatomic, retain)NSString *labStr;//盈利率
@property (nonatomic, retain)NSString *labStrTwo;
@property (nonatomic, retain)NSArray *arrData;


@end
