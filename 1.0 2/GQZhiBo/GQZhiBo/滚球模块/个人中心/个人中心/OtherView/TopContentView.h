//
//  TopContentView.h
//  newGQapp
//
//  Created by genglei on 2018/6/27.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopContentViewDelegate <NSObject>

- (void)addAtention:(BOOL)attention;

@end


@interface TopContentView : UIView

@property (nonatomic , strong) UserModel *model;

@property (nonatomic, weak) id <TopContentViewDelegate> delegate;

@end
