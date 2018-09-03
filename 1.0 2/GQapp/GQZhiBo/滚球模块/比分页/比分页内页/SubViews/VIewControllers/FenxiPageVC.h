//
//  FenxiPageVC.h
//  GQapp
//
//  Created by WQ on 2017/1/13.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicViewController.h"
#import "ViewPagerController.h"
#import "LiveScoreModel.h"

@interface FenxiPageVC : BasicViewController

@property (nonatomic, strong) LiveScoreModel *model;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) NSInteger segIndex;

@end
