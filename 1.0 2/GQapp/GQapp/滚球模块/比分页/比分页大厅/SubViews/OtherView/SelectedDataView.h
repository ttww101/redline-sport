//
//  SelectedDataView.h
//  GQapp
//
//  Created by WQ on 2017/5/19.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectedDataView;
@protocol SelecterDateViewDelegate <NSObject>

@optional
- (void)SelecterMatchView:(SelectedDataView *)matchView selectedAtIndex:(NSInteger)index WithSelectedName:(NSString *)name;
- (void)touchTapView;
@end
@interface SelectedDataView : UIView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelecterDateViewDelegate> delegate;
- (void)updateSelectedIndex:(NSInteger)index;
@end
