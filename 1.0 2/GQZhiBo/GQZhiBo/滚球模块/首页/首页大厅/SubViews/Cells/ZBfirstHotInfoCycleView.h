#import <UIKit/UIKit.h>
@protocol firstHotInfoCycleViewDelegate<NSObject>
@optional
- (void)dicSelectedToFenxiWithModel:(ZBFirstPInfoListModel *)model;
@end
@interface ZBfirstHotInfoCycleView : UIView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<firstHotInfoCycleViewDelegate> delegate;
- (void)setUpData:(NSArray *)arr;
@end
