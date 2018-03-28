//
//  PeiLvDetailCell.h
//  GQapp
//
//  Created by Marjoice on 09/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeiLvDetailModel.h"

@interface PeiLvDetailCell : UITableViewCell
@property (nonatomic, strong) PeiLvDetailModel      *modelPeiLvDetail;
@property (nonatomic, strong) NSMutableArray        *array;
@property (nonatomic, strong) UILabel           *labTeamTime;
@property (nonatomic, strong) UILabel           *labTeamScore;
@property (nonatomic, strong) UILabel           *labTeamOdds;
@property (nonatomic, strong) UILabel           *labBollScore;
@property (nonatomic, strong) UILabel           *labOddsChang;
@property (nonatomic, strong) UILabel           *labMatchTime;
@end
