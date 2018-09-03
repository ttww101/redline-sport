#import <UIKit/UIKit.h>
#import "ZBCommentChildModel.h"
@protocol CommentDetailViewDelegate <NSObject>
@optional
- (void)didTouchCommentDetailViewWithUserId:(ZBCommentChildModel*)userId commentTag:(CGFloat)commentTag;
- (void)touchChildCommentViewWithIdid:(NSInteger)Idid;
@end
@interface ZBCommentDetailView : UIView
@property (nonatomic, strong) ZBCommentChildModel *model;
@property (nonatomic, weak) id<CommentDetailViewDelegate> delegate;
- (void)hideHudView;
@end
