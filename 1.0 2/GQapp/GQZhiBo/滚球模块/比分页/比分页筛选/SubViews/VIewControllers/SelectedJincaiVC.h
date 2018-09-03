//
//  SelectedJincaiVC.h
//  GQapp
//
//  Created by WQ_h on 16/8/29.
//  Copyright © 2016年 GQXX. All rights reserved.
//
#import "SelectedAllVC.h"

#import "BasicViewController.h"
@protocol SelectedJincaiVCDelegate <NSObject>
@optional
- (void)confirmSelectedJincaiWithData:(NSArray *)arrSaveData;
@end
@interface SelectedJincaiVC : BasicViewController
@property (nonatomic, weak) id<SelectedJincaiVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
//区分是从哪个页面跳进来进行筛选
@property (nonatomic) typeSaishiSelecterdVC type;

@end
