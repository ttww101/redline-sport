//
//  ZBTuijianDetailCommentCell.h
//  GQapp
//
//  Created by WQ_h on 16/8/4.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBCommentModel.h"
#import "ZBCommentChildModel.h"
typedef NS_ENUM(NSInteger,typeCommentCell)
{
    typeCommentCellTuijian = 0,
    typeCommentCellZixun = 1,

};
@protocol TuijianDetailCommentCellDelegate<NSObject>
@optional
- (void)didShowMoreBtn;
- (void)touchBasicViewToHideHudViewWithIdid:(NSInteger)Idid;

@end
@interface ZBTuijianDetailCommentCell : UITableViewCell
@property (nonatomic, strong) ZBCommentModel *model;
@property (nonatomic, weak) id<TuijianDetailCommentCellDelegate> delegate;
@property (nonatomic) typeCommentCell type;
//影藏上面所有的hud
- (void)hideHudView;
@end
