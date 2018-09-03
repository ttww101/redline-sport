//
//  ZBFirstPUserlistView.h
//  GQapp
//
//  Created by WQ on 16/11/1.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBUserlistModel.h"

@protocol FirstPUserlistViewDelegate <NSObject>

@optional
- (void)selectedUserWithId:(ZBUserlistModel *)user;

@end

@interface ZBFirstPUserlistView : UIView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<FirstPUserlistViewDelegate> delegate;
@end
