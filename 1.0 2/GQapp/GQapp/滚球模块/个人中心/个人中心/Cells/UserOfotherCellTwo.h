//
//  UserOfotherCellTwo.h
//  GQapp
//
//  Created by WQ on 2017/8/17.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserOfotherCellTwoDelegate<NSObject>

@optional
- (void)attentionBtnClick:(UIButton *)btn;
- (void)upDownBtnClick:(BOOL)selected;

@end
@interface UserOfotherCellTwo : UITableViewCell
@property (nonatomic, strong) UserModel *model;
@property (nonatomic, assign) BOOL showMoreUserInfo;
@property (nonatomic, weak) id<UserOfotherCellTwoDelegate> delegate;
@end
