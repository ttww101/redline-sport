//
//  ZBHSTabBarContentView.h
//  ZBHSTabBarContentView
//
//  Created by Marjoice on 09/08/17.
//  Copyright © 2017年 zhuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZBHSTabBarContentView;

@protocol HSTabBarContentViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView;
- (NSString *)tabBarContentView:(ZBHSTabBarContentView *)tabBarContentView titleForItemAtIndex:(NSInteger)index;
- (UIView *)tabBarContentView:(ZBHSTabBarContentView *)tabBarContentView contentViewAtIndex:(NSInteger)index;
@end

@protocol HSTabBarContentViewDelegate <NSObject>
@optional
- (CGFloat)heightForTabBarInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView;
- (UIColor *)colorForTabBarItemTextInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView;
- (UIColor *)highlightColorForTabBarItemInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView;
- (UIView *)highlightViewForTabBarItemInTabBarContentView:(ZBHSTabBarContentView *)tabBarContentView;
- (void)tabBarContentView:(ZBHSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index;
@end

@interface ZBHSTabBarContentView : UIView
@property (weak, nonatomic)   id<HSTabBarContentViewDataSource>     dataSource;
@property (weak, nonatomic)   id<HSTabBarContentViewDelegate>       delegate;
@property (strong, nonatomic)   UIView                              *tabBarBackgroundView;
@property (assign, nonatomic)  BOOL                                 bottomLineHide;
@property (assign, nonatomic) CGFloat                               titleFont;
@property (assign, nonatomic) NSInteger                             selectedIndex;
@property (nonatomic, assign) long   titleFlag;

- (void)realoadTabBar;
- (void)reloadData;

@end
