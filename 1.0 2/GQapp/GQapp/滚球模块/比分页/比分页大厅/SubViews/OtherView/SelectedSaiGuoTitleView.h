//
//  SelectedSaiGuoTitleView.h
//  GQapp
//
//  Created by Marjoice on 07/09/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "QiciModel.h"
#import <UIKit/UIKit.h>
@protocol SelectedSaiGuoTitleViewDelegate<NSObject>
@optional
//1 中间  2 上一期    3 下一期
- (void)selectedSaiGuoViewIndex:(NSInteger)index;
@end
@interface SelectedSaiGuoTitleView : UIView
//如果是赛果的话，上一期和下一期位置调换
@property (nonatomic, assign) BOOL isSaiguo;
@property (nonatomic, assign) BOOL isBeforeTwo; // 全部，竞彩
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelectedSaiGuoTitleViewDelegate> delegate;

- (void)setDateIndex:(NSInteger)index;

@end
