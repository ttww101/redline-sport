//
//  ZBSelectedViewOfFabuTuijian.h
//  GQapp
//
//  Created by WQ on 16/11/21.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBDxModel.h"//大小球
@protocol SelectedViewOfFabuTuijianDelegate <NSObject>

@optional
- (void)didselectedAtIndex:(NSInteger)index WithModel:(ZBDxModel *)selectedModel WithCompanyIndex:(NSInteger)companyIndex;

@end

@interface ZBSelectedViewOfFabuTuijian : UIView
//先赋值
@property (nonatomic, assign)NSInteger newTypeNum;//选择的玩法
@property (nonatomic, assign)NSInteger companyIndex;//公司的id

@property (nonatomic, strong) ZBDxModel *model;
@property (nonatomic, weak) id<SelectedViewOfFabuTuijianDelegate> delegate;
- (void)clearbackGroundImage;
- (void)setCurrentIndex:(NSInteger )index;
@end
