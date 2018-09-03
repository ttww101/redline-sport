//
//  ZBSelectedChupanVC.h
//  GQapp
//
//  Created by WQ_h on 16/8/29.
//  Copyright © 2016年 GQXX. All rights reserved.
//
#import "ZBSelectedAllVC.h"

#import "ZBBasicViewController.h"
@protocol SelectedChupanVCDelegate <NSObject>
@optional
- (void)confirmSelectedChupanWithData:(NSArray *)arrSaveData;
@end

@interface ZBSelectedChupanVC : ZBBasicViewController
@property (nonatomic, weak) id<SelectedChupanVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
//区分是从哪个页面跳进来进行筛选
@property (nonatomic) typeSaishiSelecterdVC type;

@end
