//
//  CommentDetailView.h
//  GQapp
//
//  Created by WQ on 16/10/26.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentChildModel.h"

@protocol CommentDetailViewDelegate <NSObject>
@optional

- (void)didTouchCommentDetailViewWithUserId:(CommentChildModel*)userId commentTag:(CGFloat)commentTag;
- (void)touchChildCommentViewWithIdid:(NSInteger)Idid;

@end
@interface CommentDetailView : UIView
@property (nonatomic, strong) CommentChildModel *model;
@property (nonatomic, weak) id<CommentDetailViewDelegate> delegate;
//影藏上面所有的hud
- (void)hideHudView;
@end
