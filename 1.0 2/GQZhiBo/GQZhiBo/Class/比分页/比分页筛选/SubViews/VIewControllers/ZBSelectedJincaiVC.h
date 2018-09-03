#import "ZBSelectedAllVC.h"
#import "ZBBasicViewController.h"
@protocol SelectedJincaiVCDelegate <NSObject>
@optional
- (void)confirmSelectedJincaiWithData:(NSArray *)arrSaveData;
@end
@interface ZBSelectedJincaiVC : ZBBasicViewController
@property (nonatomic, weak) id<SelectedJincaiVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic) typeSaishiSelecterdVC type;
@end
