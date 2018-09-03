//
//  TuijianDetailVC.h
//  GQapp
//
//  Created by WQ_h on 16/8/3.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicViewController.h"
#import "TuijiandatingModel.h"
#import "TuijianDetailTableView.h"

@interface TuijianDetailVC : BasicViewController
@property (nonatomic, assign) typeTuijianDetailHeaderCell typeTuijianDetailHeader;
@property (nonatomic, assign) NSInteger modelId;
@property (nonatomic, assign) NSInteger status;
@end
