//
//  ZBSelectedDateTitleView.h
//  GQapp
//
//  Created by WQ on 2017/5/25.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#import "ZBQiciModel.h"
#import <UIKit/UIKit.h>
@protocol SelectedDateTitleViewDelegate<NSObject>
@optional
//1 中间  2 上一期    3 下一期
- (void)selectedDateViewIndex:(NSInteger)index;
@end
@interface ZBSelectedDateTitleView : UIView
//如果是赛果的话，上一期和下一期位置调换
@property (nonatomic, assign) BOOL isSaiguo;
@property (nonatomic, assign) BOOL isBeforeTwo; // 全部，竞彩
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelectedDateTitleViewDelegate> delegate;

- (void)setDateIndex:(NSInteger)index;

@end
