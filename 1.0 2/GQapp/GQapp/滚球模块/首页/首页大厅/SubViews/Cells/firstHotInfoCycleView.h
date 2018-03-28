//
//  firstHotInfoCycleView.h
//  GQapp
//
//  Created by WQ on 2017/7/18.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol firstHotInfoCycleViewDelegate<NSObject>
@optional
- (void)dicSelectedToFenxiWithModel:(FirstPInfoListModel *)model;

@end

@interface firstHotInfoCycleView : UIView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<firstHotInfoCycleViewDelegate> delegate;
- (void)setUpData:(NSArray *)arr;

@end
