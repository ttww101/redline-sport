//
//  ZBSelectedCCell.h
//  GQapp
//
//  Created by WQ_h on 16/8/29.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBBIfenSelectedSaishiModel.h"
@interface ZBSelectedCCell : UICollectionViewCell
//先赋值给cellwidth
@property (nonatomic, assign) CGSize cellSize;

@property (nonatomic, strong) ZBBIfenSelectedSaishiModel *model;
@end
