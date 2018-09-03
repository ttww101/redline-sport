//
//  ZBCustmerTableBar.h
//  newGQapp
//
//  Created by genglei on 2018/5/28.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZBCustmerTableBar;

@protocol TabBarDelegate <NSObject>
/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
@optional

- (BOOL)tabBar:(ZBCustmerTableBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to;

- (void)tabBar:(ZBCustmerTableBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to viewController:(UIViewController *)viewController;

@end

@interface ZBCustmerTableBar : UIView

@property (nonatomic, assign) BOOL isLoad; // 判断是否加载网络图片 add by GL
@property(nonatomic, strong) NSArray *itemsArr;
@property(nonatomic, weak) id <TabBarDelegate> delegate;
@property(nonatomic, assign) NSInteger selected;
@property(nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray* arrayDefluts;
@property (nonatomic, strong) NSArray* arraySelects;

@end
