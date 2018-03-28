//
//  FenxiHeaderView.h
//  GQapp
//
//  Created by WQ on 2017/2/7.
//  Copyright © 2017年 GQXX. All rights reserved.
//

@protocol FenxiHeaderViewDelegate <NSObject>

- (void)backClick:(NSInteger)btnTag;

@end

#import <UIKit/UIKit.h>
#import "LiveScoreModel.h"

@interface FenxiHeaderView : UIView
@property (nonatomic, strong) UIButton *imageRight;

@property (nonatomic, weak)id<FenxiHeaderViewDelegate>delegate;

@property (nonatomic, strong) LiveScoreModel *model;
- (void)hideBottom;
- (void)showBottom;
- (void)changeCountTimeWithTime:(NSString *)countTime;
- (void)updateScroeWithmodel:(LiveScoreModel *)liviModel;
@end
