//
//  PeiLvDetailVC.h
//  GQapp
//
//  Created by Marjoice on 09/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "BasicTableView.h"
#import "LiveScoreModel.h"

//前两种，后两种
typedef NS_ENUM(NSInteger,PeiLvCellType){
    isBeforeTwo = 0,
    isAfterTwo = 1,
};

@interface PeiLvDetailVC : BasicViewController
@property (nonatomic, strong) LiveScoreModel                        *model;
@property (nonatomic, assign) PeiLvCellType                         PeiLvCType;

@end
