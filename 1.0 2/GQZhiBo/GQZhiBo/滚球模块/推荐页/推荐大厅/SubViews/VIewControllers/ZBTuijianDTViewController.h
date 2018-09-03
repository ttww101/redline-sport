//
//  ZBTuijianDTViewController.h
//  GQapp
//
//  Created by WQ on 16/11/7.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicViewController.h"
#import "ZBTuijianDatingTable.h"

@interface ZBTuijianDTViewController : ZBBasicViewController
@property (nonatomic, strong) ZBTuijianDatingTable *tableViewV;
@property (nonatomic, assign)NSInteger setConSize;//重新设置偏移量

@property (nonatomic, assign) NSInteger playType;

@end
