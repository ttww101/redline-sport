//
//  ZBFenxiPageVC.h
//  GQapp
//
//  Created by WQ on 2017/1/13.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicViewController.h"
#import "ZBViewPagerController.h"
#import "ZBLiveScoreModel.h"

@interface ZBFenxiPageVC : ZBBasicViewController

@property (nonatomic, strong) ZBLiveScoreModel *model;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) NSInteger segIndex;

@end
