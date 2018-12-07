#import "ZBQiciModel.h"
#import <UIKit/UIKit.h>
@protocol SelectedDateTitleViewDelegate<NSObject>
@optional
- (void)selectedDateViewIndex:(NSInteger)index;
- (void)ZBSelectedDateTitleViewDidAction:(NSArray *)array;
@end
@interface ZBSelectedDateTitleView : UIView
@property (nonatomic, assign) BOOL isSaiguo;
@property (nonatomic, assign) BOOL isBeforeTwo; 
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<SelectedDateTitleViewDelegate> delegate;
@end
