//
//  ZBSelecterMatchView.h
//  CCAV5
//
//  Created by WQ on 2017/3/9.
//  Copyright © 2017年 Gunqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZBSelecterMatchView;
@protocol SelecterMatchViewDelegate <NSObject>

@optional
- (void)ZBSelecterMatchView:(ZBSelecterMatchView *)matchView selectedAtIndex:(NSInteger)index;
- (void)touchTapView;

@end

@interface ZBSelecterMatchView : UIView
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelecterMatchViewDelegate> delegate;
@end
