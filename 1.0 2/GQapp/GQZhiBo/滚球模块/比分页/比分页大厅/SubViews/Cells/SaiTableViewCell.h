//
//  SaiTableViewCell.h
//  GunQiuLive
//
//  Created by WQ_h on 16/1/28.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveScoreModel.h"
#import "LivingModel.h"
@interface SaiTableViewCell : UITableViewCell
@property (nonatomic, strong) LiveScoreModel *ScoreModel;
//要先赋值给 peilvIndex 再给LiveScoreModel
@property (nonatomic, assign) int peilvIndex;

// 0 attention  1 living   2 notbegin   3 complate
@property (nonatomic, assign) int SaishiType;
@end
