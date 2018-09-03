#import <UIKit/UIKit.h>
@class ZBCommentsView;
@protocol CommentsViewDelegate <NSObject>
- (void)commentViewDidSelectCommnetList:(ZBCommentsView *)commentView;
- (void)commentViewDidSelectReply:(ZBCommentsView *)commentView;
- (void)commentViewDidSelectShare:(ZBCommentsView *)commentView;
@end
@interface ZBCommentsView : UIView
@property (nonatomic , copy) NSString *newsID;
@property (nonatomic , copy) NSString *module;
- (void)loadData;
@property (nonatomic, weak) id <CommentsViewDelegate> delegate;
@end
