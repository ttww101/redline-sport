//
//  ZBAnalystsEventFilterVC.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/5/12.
//  Copyright © 2017年 GQXX. All rights reserved.
//

@protocol AnalystsEventFilterVCDelegate <NSObject>

- (void)backStr:(NSString *)str;

@end

#import "ZBBasicViewController.h"

@interface ZBAnalystsEventFilterVC : ZBBasicViewController

@property (nonatomic, assign)id<AnalystsEventFilterVCDelegate> delegate;

@end
