//
//  HSTabBarContentView.h
//  HSTabBarContentView
//
//  Created by Marjoice on 09/08/17.
//  Copyright © 2017年 zhuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSTabBarContentView;

@protocol HSTabBarContentViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInTabBarContentView:(HSTabBarContentView *)tabBarContentView;
- (NSString *)tabBarContentView:(HSTabBarContentView *)tabBarContentView titleForItemAtIndex:(NSInteger)index;
- (UIView *)tabBarContentView:(HSTabBarContentView *)tabBarContentView contentViewAtIndex:(NSInteger)index;
@end

@protocol HSTabBarContentViewDelegate <NSObject>
@optional
- (CGFloat)heightForTabBarInTabBarContentView:(HSTabBarContentView *)tabBarContentView;
- (UIColor *)colorForTabBarItemTextInTabBarContentView:(HSTabBarContentView *)tabBarContentView;
- (UIColor *)highlightColorForTabBarItemInTabBarContentView:(HSTabBarContentView *)tabBarContentView;
- (UIView *)highlightViewForTabBarItemInTabBarContentView:(HSTabBarContentView *)tabBarContentView;
- (void)tabBarContentView:(HSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index;
@end

@interface HSTabBarContentView : UIView
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
