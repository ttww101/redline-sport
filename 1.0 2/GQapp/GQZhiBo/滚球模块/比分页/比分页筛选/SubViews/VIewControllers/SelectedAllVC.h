//
//  SelectedAllVC.h
//  GQapp
//
//  Created by WQ_h on 16/8/25.
//  Copyright © 2016年 GQXX. All rights reserved.
//
typedef NS_ENUM(NSInteger, typeSaishiSelecterdVC)
{
    typeSaishiSelecterdVCBifen = 0,
    typeSaishiSelecterdVCTuijian = 1,
    typeSaishiSelecterdVCInfo = 2,

};

#import "BasicViewController.h"
@protocol SelectedAllVCDelegate <NSObject>
@optional
- (void)confirmSelectedAllWithData:(NSArray *)arrSaveData;
@end
@interface SelectedAllVC : BasicViewController
@property (nonatomic, weak) id<SelectedAllVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
//区分是从哪个页面跳进来进行筛选
@property (nonatomic) typeSaishiSelecterdVC type;

@end
