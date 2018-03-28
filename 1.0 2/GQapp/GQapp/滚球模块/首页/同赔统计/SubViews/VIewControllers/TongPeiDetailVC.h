//
//  TongPeiDetailVC.h
//  GQapp
//
//  Created by WQ on 2017/8/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicViewController.h"

@interface TongPeiDetailVC : BasicViewController
@property (nonatomic, assign) NSInteger scheduleId;
@property (nonatomic, assign) NSInteger sclassId;
//1：亚盘   2大小球  0胜平负
@property (nonatomic, assign) NSInteger pelvIndex;

@end
