//
//  TuijianDTViewController.h
//  GQapp
//
//  Created by WQ on 16/11/7.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicViewController.h"
#import "TuijianDatingTable.h"

@interface TuijianDTViewController : BasicViewController
@property (nonatomic, strong) TuijianDatingTable *tableViewV;
@property (nonatomic, assign)NSInteger setConSize;//重新设置偏移量
@end
