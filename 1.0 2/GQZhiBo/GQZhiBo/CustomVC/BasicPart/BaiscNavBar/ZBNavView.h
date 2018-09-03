//
//  ZBNavView.h
//  GQapp
//
//  Created by WQ on 2017/4/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NavViewDelegate<NSObject>
@optional
- (void)navViewTouchAnIndex:(NSInteger)index;
- (void)navViewTouchButton:(UIButton *)btn;

@end
@interface ZBNavView : UIView
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, weak) id<NavViewDelegate> delegate;
@end
