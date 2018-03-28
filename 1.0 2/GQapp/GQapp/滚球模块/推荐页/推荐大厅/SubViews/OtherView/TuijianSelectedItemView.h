//
//  TuijianSelectedItemView.h
//  GQapp
//
//  Created by WQ on 2017/8/24.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TuijianSelectedItemViewDelegate<NSObject>
@optional
- (void)touchBgView;
- (void)selectedWithItem:(NSInteger)item WithIndex:(NSInteger)index WithTitle:(NSString *)title;
//不做加载数据的操作
- (void)touchWithItem:(NSInteger)item WithIndex:(NSInteger)index WithTitle:(NSString *)title;

@end
@interface TuijianSelectedItemView : UIView
@property (nonatomic, strong) NSArray *arrSaishi;
@property (nonatomic,weak) id<TuijianSelectedItemViewDelegate> delegate;
- (void)updateWithIndex:(NSInteger)index;
- (void)updateWithIndexAttentioned:(BOOL)selected;

@end
