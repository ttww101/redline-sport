//
//  TabbarButton.h
//  newGQapp
//
//  Created by genglei on 2018/5/28.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarButton : UIButton

@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, strong) NSString* deflut;
@property (nonatomic, strong) NSString* select;
@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) CALayer* flag;


- (void)setTabbarImage:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)titleStr;

@end