//
//  UserOfOtherCell.h
//  GQapp
//
//  Created by WQ on 2017/4/26.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserOfOtherCellDelegate<NSObject>
@optional
- (void)attentionBtnClick:(UIButton *)btn;
- (void)navBtnClick:(NSInteger)index;
- (void)tuijianBtnClick:(NSInteger)index;
- (void)upDownBtnClick:(BOOL)selected;

@end
@interface UserOfOtherCell : UITableViewCell
@property (nonatomic, strong) UserModel *model;
@property (nonatomic, weak) id<UserOfOtherCellDelegate> delegate;
@property (nonatomic, assign) BOOL showMoreUserInfo;
@end
