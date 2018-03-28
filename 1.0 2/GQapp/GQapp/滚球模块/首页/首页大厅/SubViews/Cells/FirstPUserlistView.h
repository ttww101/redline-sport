//
//  FirstPUserlistView.h
//  GQapp
//
//  Created by WQ on 16/11/1.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserlistModel.h"

@protocol FirstPUserlistViewDelegate <NSObject>

@optional
- (void)selectedUserWithId:(UserlistModel *)user;

@end

@interface FirstPUserlistView : UIView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<FirstPUserlistViewDelegate> delegate;
@end
