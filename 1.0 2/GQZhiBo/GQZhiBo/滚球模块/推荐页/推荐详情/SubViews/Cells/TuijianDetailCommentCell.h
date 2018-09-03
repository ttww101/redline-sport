//
//  TuijianDetailCommentCell.h
//  GQapp
//
//  Created by WQ_h on 16/8/4.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "CommentChildModel.h"
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
@interface TuijianDetailCommentCell : UITableViewCell
@property (nonatomic, strong) CommentModel *model;
@property (nonatomic, weak) id<TuijianDetailCommentCellDelegate> delegate;
@property (nonatomic) typeCommentCell type;
//影藏上面所有的hud
- (void)hideHudView;
@end
