//
//  UserViewOfTuijianCell.h
//  GQapp
//
//  Created by WQ on 16/11/3.
//  Copyright © 2016年 GQXX. All rights reserved.
//
#import "TuijiandatingModel.h"
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, typeTuijianCell)
{
    typeTuijianCellDating = 0,
    typeTuijianCellFenxi = 1,
    typeTuijianCellUser = 2,
    typeTuijianCellTuijianDetail = 3,
    typeTuijianCellFirstPage = 4,
    typeTuijianCellMybuy = 5

};
@interface UserViewOfTuijianCellCopy : UIView
- (void)setValueWithUserTitle:(NSString *)title
                      Pic:(NSString *)pic
                ArrTitles:(NSArray *)titls
                  Remark:(NSArray *)remark
                      Win:(NSString *)win
                  Profite:(NSString *)profite
                    Round:(NSString *)round
                     Fans:(NSString *)fans
                       Userid:(NSInteger)Idid
                    colorType:(NSInteger)type
                    cellType:(typeTuijianCell)celltype
                         readCount:(NSString *)readCount
                     dayRange:(NSString *)dayRange
                    WithModel:(TuijiandatingModel *)model
;

@end
