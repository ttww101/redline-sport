//
//  ZBFenxiHeaderView.h
//  GQapp
//
//  Created by WQ on 2017/2/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//

@protocol FenxiHeaderViewDelegate <NSObject>

- (void)backClick:(NSInteger)btnTag;

@end

#import <UIKit/UIKit.h>
#import "ZBLiveScoreModel.h"

@interface ZBFenxiHeaderView : UIView
@property (nonatomic, strong) UIButton *imageRight;

@property (nonatomic, weak)id<FenxiHeaderViewDelegate>delegate;

@property (nonatomic, strong) ZBLiveScoreModel *model;
- (void)hideBottom;
- (void)showBottom;
- (void)changeCountTimeWithTime:(NSString *)countTime;
- (void)updateScroeWithmodel:(ZBLiveScoreModel *)liviModel;
@end
