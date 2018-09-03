//
//  ZBUserTuijianTable.h
//  GQapp
//
//  Created by WQ on 2017/4/26.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBUserTuijianTable : ZBBasicTableView
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger oddtype;
- (void)loadNewData;
@end
