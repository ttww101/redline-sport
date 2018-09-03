//
//  ZBPeiLvDetailVC.h
//  GQapp
//
//  Created by Marjoice on 09/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBBasicTableView.h"
#import "ZBLiveScoreModel.h"

//前两种，后两种
typedef NS_ENUM(NSInteger,PeiLvCellType){
    isBeforeTwo = 0,
    isAfterTwo = 1,
};

@interface ZBPeiLvDetailVC : ZBBasicViewController
@property (nonatomic, strong) ZBLiveScoreModel                        *model;
@property (nonatomic, assign) PeiLvCellType                         PeiLvCType;

@end
