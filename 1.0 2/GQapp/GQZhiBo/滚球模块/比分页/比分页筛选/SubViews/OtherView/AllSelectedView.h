//
//  AllSelectedView.h
//  GQapp
//
//  Created by WQ_h on 16/8/25.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AllSelectedViewDelegate<NSObject>
@optional
- (void)didSelectedAtBtnIndex:(NSInteger)index whtherSelected:(BOOL)selected;
@end
@interface AllSelectedView : UIView
@property (nonatomic, strong) UIButton *btnAll;
@property (nonatomic, weak) id<AllSelectedViewDelegate> delegate;
- (void)changeBtnSelectedState:(BOOL)isSelected;
@property (nonatomic, strong) UIButton *btnConfirm;
@end
