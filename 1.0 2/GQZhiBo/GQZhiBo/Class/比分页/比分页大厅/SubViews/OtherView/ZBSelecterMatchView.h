#import <UIKit/UIKit.h>
@class ZBSelecterMatchView;
@protocol SelecterMatchViewDelegate <NSObject>
@optional
- (void)ZBSelecterMatchView:(ZBSelecterMatchView *)matchView selectedAtIndex:(NSInteger)index;
- (void)touchTapView;
@end
@interface ZBSelecterMatchView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelecterMatchViewDelegate> delegate;
@end
