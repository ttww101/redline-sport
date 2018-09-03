//
//  ZBDan_StringGuanVC.h
//  GQapp
//
//  Created by 叶忠阳 on 16/8/25.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBBasicViewController.h"

@interface ZBDan_StringGuanVC : ZBBasicViewController

@property (nonatomic, assign)NSInteger flag;
@property (nonatomic, assign)NSInteger dan_Chuan;

//区分全部竞彩北单足彩
@property (nonatomic, strong)NSString *jsonStr;

@end
