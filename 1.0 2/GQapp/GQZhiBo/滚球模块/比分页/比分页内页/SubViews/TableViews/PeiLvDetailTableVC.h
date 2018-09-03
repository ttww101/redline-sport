//
//  PeiLvDetailTableVC.h
//  GQapp
//
//  Created by Marjoice on 09/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "BasicTableView.h"
#import "PeiLvDetailModel.h"
#import "LiveScoreModel.h"

typedef NS_ENUM(NSInteger,PeiLvDetailCellType){
    isDetailBeforeTwo = 0,
    isDetailAfterTwo = 1,
};
typedef NS_ENUM(NSInteger,oddsType){
    oddsTypeRangQiu = 1,
    oddsTypeDaXiao = 2,
};
typedef NS_ENUM(NSInteger,isHalfType){
    isHalfQuanChang = 0,
    isHalfBanChange = 1,
};
typedef NS_ENUM(NSInteger,jiaoQiuType){
    isJiaoQiuDaXiao = 2,
    isJiaoQiuRangFen = 1,
};
@interface PeiLvDetailTableVC : BasicViewController
@property (nonatomic, strong) PeiLvDetailModel                      *peiLvDetailModel;
@property (nonatomic, strong) LiveScoreModel                        *model;
@property (nonatomic, assign) isHalfType                            isHalfType;
@property (nonatomic, assign) oddsType                              oddsType;
@property (nonatomic, assign) jiaoQiuType                           jiaoQiuType;
@property (nonatomic, assign) PeiLvDetailCellType                   PeiLvCDetailType;

@end
