//
//  ZBTitleIndexView.h
//  GQapp
//
//  Created by WQ on 2017/4/24.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TitleIndexViewDelegate<NSObject>
@optional
- (void)didSelectedAtIndex:(NSInteger)index;
@end

@interface ZBTitleIndexView : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat pageWidth;

@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, strong) UIColor *seletedColor;
@property (nonatomic, strong) UIColor *nalColor;
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, weak) id<TitleIndexViewDelegate> delegate;
//更新选择的是第几个
- (void)updateSelectedIndex:(NSInteger)index;
//设置第几个 按钮不能点击，变灰
- (void)selectedEndNO:(NSInteger)index;
@end
